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

## Research tasks:
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

## Jira tickets
1. Update artifact(s)
	- Determine whether one big artifact or one per location
	- **acceptance criteria**: generate artifact
2. Initialize household and business addresses
	- Sample from all locations for state/puma
	- **acceptance criteria**: initialize a sim and ensure all locations exist
3. Update new (household and business) addresses
	- Update puma/state upon move
	- **acceptance criteria**: run a sim and ensure people are moving about
---
## Proposals
Early design proposal

**General restrictions / out of scope**
- People need to move around the country but not yet match actual migration patterns (which will be addressed in MIC-3678 and MIC-3679)
- There is to be zero correlation between an individual's address and their job address
- Known limitation: simulants will only move within their shard
- 

### Update artifacts
- The FL artifact is <500MB (including non-population stuff as well). if we assume the same size (wrong assumption) then 52\*500 = 26gb of data. Is that too large for a single artifact? idk.
- Alternatively, we can perhaps have separate artifacts for each location (just population, presumably, with a single artifact for non-pop stuff?)
	- Even in this case when it comes time to sample we'd need to read them all in to sample from
	- Might just be worth doing one big artifact and fixing later if the size ever becomes a problem
	- ❓ We previously assumed that sampling would be quicker with individual artifacts. But how/why? It seems like we'd still need to read everything in so that we correctly sample given that state pops are vastly different.

### Initialize addresses
- Uniformly sample from list of pumas
- TODO: 

### Update addresses
- Households
	- `address_id` is already implemented
	- `state` and `puma` - from docs:
		<blockquote>
				A new state and PUMA should be selected for the household according to the proportions in the “Destination PUMA proportions by source PUMA” input file <bold>where the state and PUMA columns match the household’s current state and PUMA</bold>. (If the simulation’s catchment area is only certain states/PUMAs, this file should be filtered to only the sources and destinations in the simulation catchment area.) The household should be assigned new physical and mailing addresses, with the same procedure used at initialization.
			</blockquote>
		1. Load this file (where is it?)
		2. 
- Individuals


#Designs/PRL 
