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
	- Responses: Household number; simulant id; first name; middle initial; last name; age; dob; home address; home zip code
	- Stratifications: State
	- Additional (for noise functions): birthday, tracked guardian(s), tracked guardian(s) address(es), type of group quarter 
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
	- Each time step -> 12,000x~17 (ACS) + 60,000x~17 (CPS)
		- Using the larger, that's 17 columns by 60k x 365/28 x 30? years = >23M rows
	- ❓Do we save each hdf out separately? Or append into a mega-dataset?
	- ❓Would it be better to save out the data with household address as the index?
		- This would result in a sparse dataset and also require reshaping the data at each time step - probably too slow
	- ❓There's a note to oversample by 2x - is this still relevant?
	- ❓are the sample rates pre- or post-response filtering? eg should the ACS survey results be 12k houeholds long or less due to non-reponse?
	- ❓what exactly is needed by stratifying by state?
		- [ ] Propose that we just do a uniform sample nationwide
	- ❓Are the non-response rates related at all to the household level?
	- ❓Are we sampling 60k and 12k per year or per time step?
	- [ ] where does the 27.6% non-observant rate for cps survey come from?
	- [ ] What columsn are required for cps survey? Seems like it should have job, etc
	- [ ] Do the non-response rates need to be configurable? If so, then we should filter away on the backend.
- Observer will need to also map all of the column IDs to strings, as appropriate (eg address ID to address)
	- Should this happen once at each time step before observing? Or save out

### Considerations/concerns
- Space - this is going to be a lot of data. is hdf good enough?
- sampling appropriately in a parallel sim - I don't think there's an issue here but need to be sure
- stratifying by state if different states end up in different sims - do we need to post-aggregate those? Or is it just not an issue?

## Pseudocode
I think a straightfoward implementation is appropriate here. The only tricky part I think will be the sampling itself (the current census observers samples a constant 95% of the population but this implements various lookup tables based on sex, age, race, etc to determine non-response)
``` python
def setup(self, builder: Builder):
	...
	builder.event.register_listener(
		"time_step__prepare",
		self.on_time_step__prepare
	)

def on_time_step__prepare(self, event: Event) -> None:
	...
	pop = self.population_view([
		household id, simulant id, first name, middle initial,
		last name, age, dob, address, zip code, birthday,
		guardian 1, guardian 2, guardian 1 address, 
		guardian 2 address, group quarter
	])

	sampled_households = self.sample_households(pop)
	respondents = pop.loc[sampled_households]
	respondents = self.filter_non_responsive(respondents)
	responses.to_hdf()

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

#Designs/PRL/HouseholdSurveys
