Goal: A single run should be capable of running on the US (ie all 50 states)

Docs:
- Household addresses: https://vivarium-research.readthedocs.io/en/latest/models/concept_models/vivarium_census_synthdata/concept_model.html#components-1-5-age-sex-race-ethnicity-nativity-geographic-location-household-id-and-relationship
- Business addresses: https://vivarium-research.readthedocs.io/en/latest/models/concept_models/vivarium_census_synthdata/concept_model.html#employment-21
- Household movement: https://vivarium-research.readthedocs.io/en/latest/models/concept_models/vivarium_census_synthdata/concept_model.html#household-moves
- individual moviement: https://vivarium-research.readthedocs.io/en/latest/models/concept_models/vivarium_census_synthdata/concept_model.html#individual-moves

# Requirements
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
 
# Considerations:
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
		- [ ] Sort out what should happen to puma and state
	- Individuals can move; three types:
		- Move into group quarters; this does not affect this ticket
		- Move into an existing household; probably sample uniformly at random
			- The locations exist in the state table at any given time; it's a known limitation that persons can only move to a household in a given shard
		- Move into a new (unexisting) household
			- [ ] need to figure out how to generate a new puma and state
			- Do we need ACS data for this? Nope, we just need a list of the pumas.
	- Business can move (in same way as households)

# Tasks:
- [ ] Go see how code currently implements artifact and sampling
	- [ ] What exactly is loaded?
		- The artifact's `population.households` data is loaded
			- `population._load_population_data`
			- This brings in state and puma (household IDs are random and not related to anything at this point)
			- ❓ Could we loop through/load/concat all of the state-level artifacts at this point? Is this the only time we'd need to do such a thing? Is it even worth the effort compared to just having one artifact for all states?
			- Current artifact size (with just florida) is 376MB - but how much of that is just the pop stuff? I guess we could have one artifact for everything else and then state-specific artifacts for pop?
	- [ ] What is being sampled?
		- Households are then sampled from the artifact data (currently all florida)
			- `population.choose_standard_households` (uses `vectorized_choice`)
			- 
- [ ] Think a lot
- [ ] 

#Designs/PRL 
