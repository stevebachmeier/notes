Task: https://jira.ihme.washington.edu/browse/MIC-3652
RT docs: https://vivarium-research.readthedocs.io/en/latest/models/concept_models/vivarium_census_synthdata/concept_model.html#household-surveys

- Two types of sampling
	- **new random**: samples the entire population at a defined time interval
		- Note that each subsequent sample is *independent* of prior samples!
	- **longitudinal**: samples the *same* population at a defined time interval
- what to sample: household number; unique simulant ID; first name; middle initial; last name; age; dob; home address; home zip code
- Sampling eligibility: 
	- currently living in US
	- determined to participate (there is a significant amount of non-response bias in surveys compared to the annual census)
		- Refer to the *Simulant Response by Race/Ethnicity* table in the docs
		- This is a kind of confusing calculation using several different lookup tables - I'll need to spend some time on this. **It doesn't feel correct that the response rates for the different types of surveys (mail, phone, in-person) are additive**

Two household surveys: American Community Survey (ACS) and Current Population Survey (CPS)

# Design
## Requirements
- [ ] Ask for the noise functions excel sheet (working doc)
	- Keep this in mind when designing to allow for scaling later
- Required columns:
	- Responses: Household number; simulant id; first name; middle initial; last name; age; dob; home address (address id + puma + state); home zip code (not actually)
	- Stratifications: State (unlinkely to be needed)
	- Additional (for noise functions): birthday, tracked guardian(s), tracked guardian(s) address(es), type of group quarter 
		- **Don't include until they need to be**
- Sampling details:
| survey | sample rate | stratifications | frequency | method | modes | note |
| --- | --- | --- | --- | --- | --- | --- |
| ACS | 12k households | state | each time step | new random (ie independent) | mail/online, phone, and visits |  |
| CPS | 60K households | state | each time step | new random (ie independent) | phone, visits  | non-standard survey mode; see note <sup>(a)</sup> |
<sup>(a)</sup> This does not fit into the ACS framework that's used to calculate non-response rates (requires mail -> phone -> visit). This is accounted for by using the values for mail+phone+visit and then applying a 27.6% non-response rate to that

## Thoughts
- **the standard vivarium observer approach is not applicable**
	- Standard observers add values to the metrics pipeline which then gets turned into output.hdf. But this is different and I think I'd need totally unique `acs_survey` and `cps_survey` pipelines
	- Rajan confirmed
- I need to be thinking at a high level about what we want observers in general to look like
	- Tahiya suggested looking at the current census observer
	- **NOTE**: Beatrix confirmed that the currently-named `Observers` class is specifically the census observer
	- Consider removing the state table portion - they used to use it but it's not used anymore (maybe?)
- columns required are all standard state table columns (I think?)
- Basically every time step we need to sample the state table and save out
	- - ❓Do we save each hdf out separately? Or append into a mega-dataset?
		- Specifically, is saving these survey results in memory going to oom?
		- #### Napkin calculation
			- Each time step -> 12,000x~17 (ACS) + 60,000x~17 (CPS). Let's just compare this to the state table to see if these survey results are going to be obviously too large. 
			- I count that there are ~17 requested columns. Let's say 30 to account for unknown noise function requirements.
			- Further, assume 30 year survey, 2x oversampling, 4 people/household, and no sharding
			  `survey_size <= 30 x [60k*2*30*4] = 30 cols x 14.4 million rows`
			  - Meanwhile, the state table, assuming 350 million population and likely hundres of rows is obviously much larger

			  **Given that the state table size >> an individual survey size, let's keep in memory and save out only at end. This saves us on I/O and prevents needing to do a bunch of post-processing (note that this is exactly how standard vivarium observers work with the `Counter` object**
			  
	- ❓Would it be better to save out the data with household address as the index?
		- This would result in a sparse dataset and also require reshaping the data at each time step - probably too slow
	- ❓There's a note to oversample by 2x - is this still relevant?
	- ~~❓are the sample rates pre- or post-response filtering? eg should the ACS survey results be 12k houeholds long or less due to non-reponse?~~
	- ~~❓what exactly is needed by stratifying by state?~~
		- [ ] ~~Propose that we just do a uniform sample nationwide~~
	- ❓Are the non-response rates related at all to the household level?
	- ~~❓Are we sampling 60k and 12k per year or per time step?~~
- Observer will need to also map all of the column IDs to strings, as appropriate (eg address ID to address)
	- Should this happen once at each time step before observing? Or save out

### Considerations/concerns
- Space - this is going to be a lot of data. is hdf good enough?
	- See above hand calc - it should be fine b/c much smaller than state table anyway
- sampling appropriately in a parallel sim - I don't think there's an issue here but need to be sure
	- will be fine if we do a uniform nation-wide sampling
- stratifying by state if different states end up in different sims - do we need to post-aggregate those? Or is it just not an issue?
	- Rajan confirmed this shouldn't be an issue b/c we wouldn't shard by location

## Followup questions
- [ ] Sample 12k and 60k per year or per time step?
- [ ] Is it fine to do a uniform sample nationwide? (in response to the docs saying to stratify by state)
- [ ]  where does the 27.6% non-observant rate for cps survey come from?
- [ ] What columns are required for cps survey? Seems like it should have job, etc
- [ ] Do the non-response rates need to be configurable? If so, then we should get everybody's response up-front and filter away on the backend.

## Pseudocode
I think a straightforward implementation is appropriate here. The only tricky part I think will be the sampling itself (the current census observers samples a constant 95% of the population but this implements various lookup tables based on sex, age, race, etc to determine non-response)
``` python

class BaseObserver:
	"""Base class for observing and recording the state table.
	It maintains a separate dataset per concrete observation and
	allows for recording/updating on some subset of timesteps
	(including every time step) and then writing out the results
	at the end of the sim.
	"""
	def __init__(self) -> None:
		pass ?

	def setup(self, builder: Builder):
		self.responses = builder.population.get_view()
		# Register the listener to update the responses
		builder.event.register_listener(
			"time_step__prepare",
			self.on_time_step__prepare
		)
		# Register the listener for final write-out
		builder.event.register_listener(
			"simulation_end",
			self.on_sim_end
		)

	def on_time_step__prepare(self, event: Event) -> None:
		pop = self.population_view([cols])
		if self.to_observe:
			respondents = self.sample_households(pop)
			responses = pop.loc[respondents]
			responses = self.filter_non_responsive(responses)

	def to_observe:
		return True  # overwrite as needed

	def sample_households(pop) -> set[int]:
		return pop  # overwrite as needed
	
	def filter_non_responsive(respondents) -> pd.DataFrame:
		return respondents  # overwrite as needed

	def on_sim_end:
		responses.to_hdf(xxx)


class HouseholdSurveyObserver(BaseObserver):
	...

	def to_observe:
		return True # class will overwrite as needed
		
	def sample_households(pop) -> set[int]:
		# Ramdomly sample 2x required households (per survey type)
		# This may not need to be a function if it's simple enough
		...
		return sampled_households

	def filter_non_responsive(respondents) -> pd.DataFrame:
		# Remove non-observers per the lookup table logic
		...
		return respondents
```

 Responses: Household number; simulant id; first name; middle initial; last name; age; dob; home address; home zip code
	- Stratifications: State
	- Additional (for noise functions): birthday, tracked guardian(s), tracked guardian(s) address(es), type of group quarter 

## Tasks
1. Build base class
	- It should by default observe all rows (and all cols?) of the state table on every timestep
	- 

#Designs/PRL/HouseholdSurveys
