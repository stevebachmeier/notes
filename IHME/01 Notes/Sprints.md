# Sprint notes

## 101
- [ ] BMI risk_effect equations still refernce rr_id 108
- [x] BMI range is too large, ~[-20, 96] - Syl will provide thresholds
	- she requirested low threshold of 5
- [x] Greg requested angina be removed
	- implemented for now by just commenting out from model_spec
- [ ] Confirm HF transition rates in new docs
    - 1: denominator is missing prev_residual_HF
        - What we're doing is starting with incidence and then scaling down (dividing) by the fraction of population that can actually go to the state of interest, ie `1 - <states that cannot transition>``
        - when she moved the HF_residual model into this one she didn't update the equation
    - 2:
    - 3: 
    - 4: 
- [ ] Have syl walk through equations

---

## 100
- [x] Are there separate outreach programs for each medication type (ie outreach for sbp adherence and ldlc adherence independently)?
	- Syl: No, its the same program. The way the math works out the percents are a little different but same program
- [x] Once a simulant is on an outreach program, can they be removed from it? And can a simulant change adherence more than once from the outreach?
	- Syl: I was imagining that once a simulant gets assigned outreach/not outreach, they will stay there forever. This means it would be a one time adherence change for simulants, but not change again.
- [x] Are we going to run scenarios where we are applying more than one intervention simultaneously (ie outreach + polypill)? The docs do not make this clear. And, if yes, they don’t describe how to deal with it.
	- Syl: No, all scenarios would be separate
* Is it overly optimistic that a simulant would forever be more adherent based on outreach? Or is the implementation of outreach in real life such that they get called more than once?
	- Yes it's optimistic but it's fine
- [x] To clarify, the coverage values (eg 50% coverage) applies to the total population, correct? It's NOT the percentage of everyone who makes it to the outreach block gets put on the program (b/c that would quickly converge on 100% coverage)
	Correct. Use a propensity column and base coverage on that (ie in the 50% scenario the maximum percetnage of the total population that could possibly be enrolled is 50%)
* What happens for someone on one medication but not the other and they get enrolled in outreach? Odes it update the adherence to both the medication they're currently on as well as the one they're not (but might get put on later)?
	- She says it's up to me to implement, though if it's a hospital-level intervention then someone should be on the intervention for all of the meds
* Is the polypill effect as written correct? Or is it going to be updated to the same approach as outreach?
	- She will update the table; though I'm not sure that makes sense.
	- She will keep it as written (which is different than sbp b/c sbp allows jumping adherence level)
- [x] For the intervention observer, do you want person-time on each intervention or just the final count of people on each intervention at the end of the sim?
	- Final count is fine. She doesn't care about how long
	- Rajan points out that what she'll get is nothing more than how many people are on the intervention at the end of the sim or when they died. That doesn't seem like what she wants. He thinks we need person-time. We'll want to know what impact being covered has on blood pressure and we'd need person-time to accurately measure that.

- [x] Check with syl about ramp logic. If already medicated and non-adherent, they never make it to the outreach block

---

## 99
- [x] Clarify what SBPlevel and LDLlevel are in the medication spread covariate equations
- [x] Clarify observers: https://ihme.slack.com/archives/C01N6LFMN3W/p1666381526746519
	- After talking with Rajan, we wonder:
		1. Do you really want total exposure * person-time stratified by medication? What do you gain by that?
			1. The original thought was that do people on medication end up w/ higher or lower sbp at the end of the day? That said, she's happy to get rid of it.
			2. She will look back at some notes. She thinks it will be fine to get rid of it.
			3. Note: she still will want the total sbp * person time stratified by everything else for V&V (to be sure we're not "curing" blood pressure and ldlc
		2. Is the new one (medication effect) supposed to be the efficacy stratified by medication type? She will take a look and get back.
	- Syl confirmed that 
		- We do not need a "medication effect" observer
		- Mean exposure (ie, total exposure * person time) does NOT need to be stratified by adherence or medication type
- ~~Confirm that exposure limits should be applied to the raw gbd data and not the adjusted values (this is basically the same question below)~~
- [x] Confirm that getting measured sbp < 50 or ldlc < 0 is acceptable.
	- The higher limit is less important to enforce.
	- There are two effects that could cause the exposures to drop low: (1) the treatment effect itself and (2) the variability when taking a measurement? So do we enforce minimums upon reading? Or do we enforce minimums as part of the treatment effect value modifier and then again upon reading?
	- Agreed the lower limits matter. Should we enforce the minimums upon reading? 
		- :question: Does a negative exposure value (if we choose to go w/ only enforcing the measured value) mess with other things like incidence rates and such?
			- DISCUSSION WITH RAJAN
				- It's impossible to have ldlc < 0 and sbp < 50 after aadjusting for treatment, so just leave the thresholds applied at gbd data
				- ALSO apply minimum thresholds when taking measurements
- [x] Confirm with Syl that it's ok we used raw gbd exposure data when taking measurements.  on Treatment() initialization (since we don't yet have the modified SBP pipelines). Yes it is
	- [x] Add to docs
- [x] Feed back to Syl the formatted sbp effect csv she provided. 
	- Done, but rename it by removing "new"
- [x] Does the ASCVD equation return %? Yes it does (zoom)
	- [x] Clarify in docs
- [x] Confirm that new therapeutic inertias should be generated at each visit. Yes, every time
	- [x] docs


---

## 98
- [x] edge case clarification: if a person goes to a doctor and leaves in a “No change” state but they also already had a follow-up scheduled for the future, do they keep that followup?
	- Yes, they keep the followup
	-  https://ihme.slack.com/archives/C01N6LFMN3W/p1663695152518319
- [x] Does stroke/ihd state affect the baseline medication?: no https://ihme.slack.com/archives/C01N6LFMN3W/p1663712766058719
	- Not added explicitly to docs but no need
- [x] Clarify parentheses imbalance for baseline medicatio coverage equations https://ihme.slack.com/archives/C01N6LFMN3W/p1663720590670429
- [x] Can a person be adherent for one medication and not another? Yes https://ihme.slack.com/archives/C01N6LFMN3W/p1663788889649189
	- Not added explicitly to docs but no need
- [x] Lots of clarifications needed for blood pressure treatment: https://ihme.slack.com/archives/C01N6LFMN3W/p1663803429558779
	- It's actually good. It's just a discrepancy on logic format between of the people who overcome therapeutic inertia and get medicated, xxx% get this and yyy% get that VS A% get nothing, B% get this, C% get that
- [x] On initialization, we have the medicine coverage spread but no scheduled followups. The docs say to schedule for anyone on meds and anyone in an acute or post-acute state. Dlo we just schedule or do we send them into the treatment ramp?
	- https://ihme.slack.com/archives/C01N6LFMN3W/p1663891533679489
	- People on meds and acute, move up ramp? Yes
	- Not everyone is initialized 0-3 months (0-3 for post, 3-6 (+ ramp) for acute)
	- DO NOT USE THE LINKS IN THE NOTE (eg initialization doc)
	- Explicitly add to docs that people in acute state should move up med ramp
- [x] Does one therapeutic inertia value in a time step apply to all medication changes (ldlc and sbp)? No, treat them separately
	- Inherent by the fact that the ldlc and sbp inertias are different
- [x] Push back on whether a missed visit can also have a background visit
	- If we do need multiple visit types in one time step, just use multiple columns
	- She agreed to if missed do not include in background https://ihme.slack.com/archives/C01N6LFMN3W/p1664304287568169
- [x] What do to w/ non-adherent people initialized on medication? https://ihme.slack.com/archives/C01N6LFMN3W/p1664387779545669
	- We should move them down to the lowest run of medcation ramp

---

## 97
CVD edge case clarifications:
- [x] edge case clarification: if a person goes to a doctor and leaves in a “No change” state but they also already had a follow-up scheduled for the future, do they keep that followup?
	- Yes, they keep the followup
	- https://ihme.slack.com/archives/C01N6LFMN3W/p1663695152518319
- [x] Does stroke/ihd state affect the baseline medication?: no https://ihme.slack.com/archives/C01N6LFMN3W/p1663712766058719
	- Not added explicitly to docs but no need
- [x] Clarify parentheses imbalance for baseline medicatio coverage equations https://ihme.slack.com/archives/C01N6LFMN3W/p1663720590670429
- [x] Can a person be adherent for one medication and not another? Yes https://ihme.slack.com/archives/C01N6LFMN3W/p1663788889649189
	- Not added explicitly to docs but no need
- [x] Lots of clarifications needed for blood pressure treatment: https://ihme.slack.com/archives/C01N6LFMN3W/p1663803429558779
	- It's actually good. It's just a discrepancy on logic format between of the people who overcome therapeutic inertia and get medicated, xxx% get this and yyy% get that VS A% get nothing, B% get this, C% get that
- [x] On initialization, we have the medicine coverage spread but no scheduled followups. The docs say to schedule for anyone on meds and anyone in an acute or post-acute state. Dlo we just schedule or do we send them into the treatment ramp?
	- https://ihme.slack.com/archives/C01N6LFMN3W/p1663891533679489
	- People on meds and acute, move up ramp? Yes
	- Not everyone is initialized 0-3 months (0-3 for post, 3-6 (+ ramp) for acute)
	- DO NOT USE THE LINKS IN THE NOTE (eg initialization doc)
	- Explicitly add to docs that people in acute state should move up med ramp
- [x] Does one therapeutic inertia value in a time step apply to all medication changes (ldlc and sbp)? No, treat them separately
	- Inherent by the fact that the ldlc and sbp inertias are different
- [x] Push back on whether a missed visit can also have a background visit
	- If we do need multiple visit types in one time step, just use multiple columns
	- She agreed to if missed do not include in background https://ihme.slack.com/archives/C01N6LFMN3W/p1664304287568169
- [x] What do to w/ non-adherent people initialized on medication? https://ihme.slack.com/archives/C01N6LFMN3W/p1664387779545669
	- We should move them down to the lowest run of medcation ramp
