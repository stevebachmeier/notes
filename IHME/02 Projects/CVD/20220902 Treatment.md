Met w/ Greg at 930am:

Greg: How does vivarium work?
- We require that gbd incidence rate occurs, and then we distribute those events weighted by risk factor exposure
Greg: We need to effect incidence rates due to interventions. Ie if we lower sbp from medicine, that person should have a lower chance of getting a disease:
- Heart failure is different than others - there are no risk-outcome pairs, but instead there are impairments
- We then need to add a custom risk-outcome pair
- The outcome Greg sent to Syl needs to go to the envelope of heart failure and then we need to proportion that out to ihd-specific
- Sbp is the most common cause for heart disease, but it leads to various kinds of heart failure (30 different causes! One of which is IHD)

Greg: do we have another way planned out besides heart failure?
- Abie: nope, let's just do heart failure complete.

Greg: The one place where everything he said isn't going to work is when computing DALYs. But to get DALYs we need cause-specific disability weights which we don't have for heart failure. We'll need to proportion out the

Greg: if we're keeping a background incidence the same over time and just proportion them out based on relative risk factors, how do we account for the effects of interventions/other scenarios?
- Syl: The incidence itself will decrease due to the interventions

Rajan: In ischemic heart disease there are a bunch of sequelae. In general we have been assuming that they are mutually exclusive and collectively exhaustive; that doesn’t seem to be the case w/ IHD. What can we assume?
- Greg - in real life they're not, but gbd tries to for the purposes of calculating YLDs. We care about MI incidence (most important b/c most likely to kill someone) as well as the total prevalence of IHD in order to calculate a reasonable YLD. Post-MI is just a convencience to track survivors.
- Angina is split (acute and chronic) to track people who have some disability but have never actually had a heart attack
    - Ths is changing completely in the next round of gbd
    - We only need this to get total prevalent IHD so that we can calculate IHD YLDs

The simplet thing would be to make the three IHD causes be mutually exclusive. Could we have the risks be independent? Then we'd have to figure out how to have the CSMR sum up to total IHD CSMR

Standard RT standup:
- We all left the meeting with Greg with different opinions (Paulina thought engineering could continue, me and Rajan thought not until documentation, Abie thought we didn't have much to do b/c the work I've done so far doesn't need to change)

Next steps: 
1. RT will look into the current models and see if they are mutually exclusive and so angine/MI are good or not.
2. RT will build a heart failure model
3. Engineering will start treatment model development

What about FPB and BMI? No docs and we may never need it - don't bother for now.https://washington.zoom.us/j/7044947072


## DISCUSSION W/ RAJAN
In the following figure, the left side is what we currently have and the right side is what Greg suggeted. BUT, they're really the same thing so we should be good
![Alt text](vscode-remote://ssh-remote%2Bslurm/mnt/share/homes/sbachmei/repos/notes/z_pictures/Screenshot%20at%20Nov%2030%2012-06-18.png)

## Treatment
- There are examples of treatment algorithms in other model repos
	- Rajan to share what repos
- What we want to do is
	- Track doctor appointments (when are you going to see the doctor)
		- Reasons to see a doctor:
			1. Emergency (acute MI or acute stroke)
			2. Scheduled appointments (note people will be initialized with already-scheduled appointments)
			3. Screening (waiting for clarification from Syl)
	- Track what happens when a doctor is seen:
		- Test sbp and cholestoral
		- Might change medication (sbp and ldl)
		- Effect of medication on exposures
- Note, treatments can be treated kind of like risks (in that they affect exposure)

- TASK 1: Schedule doctor appointments based on the actual criteria
	- TICKET 1 ARTIFACT: need outpatient envelope data in artifact
	- TICKET 2 IMPLEMENTATION
		- Some poeple should have them scheduled upon initialization (see docs for mechanism)
			□ Should be in docs about what percentage have them scheduled already
			□ Assign follow-ups in next 3 months (confirm this number from doc) 
		- On each time step, make immediate appointment upon acute event
		- On each time step if no acute event and no scheduled apointment, schedule random screenings based on outpatient envelope covariate
		- On each time step if had an appointment, Schedule followup 3-6 months away
			□ NOTE: this is not correct and needs to be changed in a later ticket when we implement exposure screenings
		- NOTE: Easiest to implement scheduled apointments by a `next_appointment` column
			□ Then if `next_appoinmtnet` <= current_time (== event_time), the appt is now (be careful that pd.NaT is nto considered <= current_time)
	- TICKET 3 OBSERVERS
		- Appointments
	- TICKET 4 V&V (if applicable, need clarification)
- TASK 2: Implement the SBP medication
	- TICKET 1 IMPLEMENT SBP EXPOSURE
		- Implement exposure to medication (probably a column in the state table w/ exposure values rather than a pipeline)
		- Initializing population
		- On time step, implement the decision tree object to determine whether someone has their exposure change
		- Assign follow-up appointments per the decision tree
	- TICKET 2 IMPLEMENT medicatiom effects (sbp)
		- Create a RiskEffect; this will need to subclass vph class b/c we need to source the column (from the previous ticket) rather than the pipeline
	- TICKET 3 OBSERVERS
		- Medication; exposure levels stratified by medication? Need clarification from RT
	- TICKET 4 V&V
- TASK 3: 
	- TICKETS: SAME AS ABOVEImplement exposure tree for ldlc
	-  Implement medicatiom effects (ldlc)
- TICKET XXX: final V&V run

## TODO:
	- Ask Syl if she wants or needs an observer for intervention, eg observing apointments? What would that look like? Rajan thought perhaps 

#treatment #cvd 