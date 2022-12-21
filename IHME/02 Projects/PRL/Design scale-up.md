Goal: A single run should be capable of running on the US (ie all 50 states)

Docs:
- Household addresses:
- Business addresses:
- Household movement:
- individual moviement:

# Requirements
- Initialization:
	- Household addresses should be spread across us
	- Business addresses across US
	- NOTE: addresses are `address_id, puma, state`; currently we are sampling from an artifact that only contains Floridians.
- should allow for mobility between locations
- Note: do NOT worry for now about household vs work address correlations (ie no need to work in the same state you live in)
	- [ ] Confirm in the docs this is true
 
# Considerations:
- Artifact:
	- Option: update artifact to account for everybody in country (ie all ACS data)
	- Option: separate artifact per location and then change code to deal with that
		- Pro: probably faster for sampling. probably.
		- Con: need code to sort out how to read the correct artifact for each location.
		- Note: memory constraint will be similar between this option and a mega-artifact option.
- mobility
	- Households can move
		- Households get a new address id. unsure about what happens w/ puma and state
		- [ ] Sort out what should happen to puma and state
	- Individuals can move; three types:
		- Move into group quarters; this does not affect this ticket
		- Move into an existing household; probably sample uniformly at random
		- Move into a new (unexisting) household
			- [ ] need to figure out how to generate a new puma and state
	- Business can move (in same way as households)

# Tasks:
- [ ] Go see how code currently implements artifact and sampling
	- [ ] What exactly is loaded?
	- [ ] What is being sampled?
- [ ] Think 

#Designs/PRL 
