Goal: A single run should be capable of running on the US (ie all 50 states)

Docs:
- Household addresses: https://vivarium-research.readthedocs.io/en/latest/models/concept_models/vivarium_census_synthdata/concept_model.html#components-1-5-age-sex-race-ethnicity-nativity-geographic-location-household-id-and-relationship
- Business addresses: https://vivarium-research.readthedocs.io/en/latest/models/concept_models/vivarium_census_synthdata/concept_model.html#employment-21
- Household movement: https://vivarium-research.readthedocs.io/en/latest/models/concept_models/vivarium_census_synthdata/concept_model.html#household-moves
- individual moviement: https://vivarium-research.readthedocs.io/en/latest/models/concept_models/vivarium_census_synthdata/concept_model.html#individual-moves

# Initial notes

## Requirements
- Initialization:
	- Household addresses should be spread across us
	- Business addresses across US
	- NOTE: addresses are `address_id, puma, state`; currently we are sampling from an artifact that only contains Floridians. The `address_id` is an arbitrary number that will be mapped later but the `puma` and `state` are sampled
- should allow for mobility between locations
- Note: do NOT worry for now about household vs work address correlations (ie no need to work in the same state you live in)
	- [x] Confirm in the docs this is true ✅ 2022-12-28
		- From docs: 
			<blockquote>
					4. Businesses change addresses completely at random. There is no bias toward local moves<br>
					5. Simulant physical address is completely unrelated to the address of their employer.<br>
					6. Businesses never share addresses with households (except by coincidence).
					</blockquote>
 
## Considerations:
- Artifact:
	- Option: update artifact to account for everybody in country (ie all ACS data)
	- Option: separate artifact per location and then change code to deal with that
		- Pro: probably faster for sampling. probably.
		- Con: need code to sort out how to read the correct artifact for each location.
		- Note: memory constraint will be similar between this option and a mega-artifact option.
- mobility
	- Households can move (https://vivarium-research.readthedocs.io/en/latest/models/concept_models/vivarium_census_synthdata/concept_model.html#household-moves)
		- Households get a new address id. 
		- A new state and puma are selected according to a proportions file (xxx) **if the state and puma columns match the household's current state and puma**
		- [x] Sort out what should happen to puma and state ✅ 2022-12-28
			- Currently there is no logic to change this - only `address_id` is changed
	- Individuals can move; three types:
		- Move into group quarters; this does not affect this ticket
		- Move into an existing household; probably sample uniformly at random
			- The locations exist in the state table at any given time; it's a known limitation that persons can only move to a household in a given shard
		- Move into a new (unexisting) household
			- [x] need to figure out how to generate a new puma and state ✅ 2022-12-28
			- Do we need ACS data for this? Nope, we just need a list of the pumas.
	- Business can move (in same way as households)

### Research tasks:
- [x] Go see how code currently implements artifact and sampling ✅ 2022-12-28
	- [x] What exactly is loaded? ✅ 2022-12-28
		- The artifact's `population.households` data is loaded
			- `population._load_population_data`
			- This brings in state and puma (household IDs are random and not related to anything at this point)
			- ❓ Could we loop through/load/concat all of the state-level artifacts at this point? Is this the only time we'd need to do such a thing? Is it even worth the effort compared to just having one artifact for all states?
			- Current artifact size (with just florida) is 376MB - but how much of that is just the pop stuff? I guess we could have one artifact for everything else and then state-specific artifacts for pop?
	- [x] What is being sampled? ✅ 2022-12-28
		- Households are then sampled from the artifact data (currently all florida)
			- `population.choose_standard_households` (uses `vectorized_choice`)

---

# Design

**General restrictions / out of scope**
- People need to move around the country but not yet match actual migration patterns (which will be addressed in MIC-3678 and MIC-3679)
- There is to be zero correlation between an individual's address and their job address
- Known limitation: simulants will only move within their shard
- No need to scale up/optimize for larger populations
- No need to design sharding/parallelization

## Tasks
1. Update artifact(s) (2 points)
	- [x] Add California population data to artifact ✅ 2023-01-04
		- NOTE: if performance becomes an issue we can look into having location-specific artifacts
	- **acceptance criteria**: 
		- [x] generate artifact ✅ 2023-01-04
2. Initialize household and business addresses (2 points)
	- No integration work required with a single artifact design
	- **acceptance criteria**: 
		- [x] integration tests ✅ 2023-01-04
3. Update addresses - implementation
	- household moves
		- [ ] Uniformly sample from list of PUMAs
			- Check w/ Zeb if this list exists already
			- NOTE: PUMAs are designed to have the same population; it should be ok for this first pass to just sample uniformly
			- NOTE: The docs call for a more complicated puma sampling but that is reserved for future work.
		- [ ] Map from PUMA to state
			- Check w/ Zeb if we hvae this map
			- NOTE: We *could* punt this mapping to post-processing but I think it's useful to have it during the sim to make it easier to debug
	- business moves - same as for households
		- [ ] Uniformly sample PUMAs from list
		- [ ] Map PUMA to state
	- **acceptance criteria**: Integration tests
		- [ ] Ensure start and end addresses are not the same (ie people moved)
			- NOTE: This test may already exist
		- [ ] Ensure that puma/state does not change if address_id does not change
		- [ ] Ensure each unique `address_id` has the same immutable puma/state
		- [ ] Ensure puma maps to correct state
			- NOTE: This seems silly since we'd just use the same map as was used to assign state, but this is really checking that some other component didn't change one and not the other
		- [ ] ❓ Ensure all states show up in the address?
			- This is population dependent so maybe not useful?
4. V&V with two states
	- [ ] Run short sim
	- **acceptance criteria**: 
		- [ ] no runtime errors
		- [ ] runs with reasonable resources compared to just Florida
		- [ ] passes all tests
		- [ ] send to RT?
5. Scale up to entire country
	- [ ] Update artifact with all locations
	- **acceptance criteria**: Artifact is generated
6. V&V
	- [ ] Run short sim
	- **acceptance criteria**:
		- [ ] No runtime errors
		- [ ] Runs with reasonable resources
		- [ ] passes all tests
		- [ ] send to RT?



---

#Designs/PRL 
