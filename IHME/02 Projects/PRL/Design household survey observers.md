Task: https://jira.ihme.washington.edu/browse/MIC-3652
RT docs: https://vivarium-research.readthedocs.io/en/latest/models/concept_models/vivarium_census_synthdata/concept_model.html#household-surveys

# General
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

# ACS
- sample rate of 12k households
- stratified by state
- sampled at each time step
- new random sampling method (ie independent samples)
- mail/online, telephone, and personal visits

# CPS
| survey | sample rate | stratifications | frequency | method | modes | note |
| --- | --- | --- | --- | --- | --- | --- |
| ACS | 12k households | state | each time step | new random (ie independent) | mail/online, phone, and visits |  |
| CPS | 60K households | state | each time step | new random (ie independent) | phone, visits  | non-standard survey mode; see note <sup>(a)</sup> |
<sup>(a)</sup> This does not fit into the ACS framework that's used to calculate non-response rates (requires mail -> phone -> visit). This is accounted for by using the values for mail+phone+visit and then applying a 27.6$ non-response rate to that

