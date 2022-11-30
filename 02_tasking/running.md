# Summary

## Nov 28
- requests to look into data from syl; released vivarium_inputs; spent some time looking into failing VI pytests
- read prl docs; working on broken vivarium_inputs pytests
- xxx
- xxx
- xxx

## Nov 21
- worked on bmi artifact; restarted polypill v&v which timed out
- finished bmi artifact and implementation; started observer/postprocessing

## Old
Nov 14	M: merged outreach effect, observer, post-processing; bug found/logged in vph default_configuration for LinearScaleUp;
	T: Started polypill
	W: finished polypill impelemtation, observers, and postprocessing
	R: 
	F: 
Nov 7	M: Working on outreach effect
	T: PRed outreacheffect; started scale-up; sorted out a few more outreach edge cases in treatment ramp
	W: implemented requested changes to OutreachEffect; finished scale-up (waiting to PR); nearly finished observer
	R: 
	F: Hol
Oct 31	M: merged sbp medication observsers/v&v; worked on ldlc effect
	T: finished ldlc effect and observers; started model 6 V&V run
	W: loads of discussion about how to implement intervention
Oct 24	M: started working on observers, but paused until clarification from syl; implemented ldlc measurements when scheduling appointments; changes from sbp med effects requests
	T: Discussed with Syl observers (still blocked); begain ldlc-medication exposure
	W: finalized observer clarifications; Pred ldlc med exposure
	R: git training; responded to ldlc med requests and merged; worked on observer
	F: 
	
Oct 17	M: working on Rajan's last suggestions for sbp exposure
	T: Wrapped up sbp exposure PR
	W: started implementing sbp med effects; confirmed no additional_keys for randomness streams in other components
	R: finished sbp med effects removal on initialization; started med effect on exposure; prepped for Friday talk
	F: 
Sep 26	M: PR sbp medication implementation
	T: 
Sep 19	M: worked on bugfix; gave up; started v&v run
	T: Lots of doc clarifications; begin implementing medication
Sep 12	M: gave presentation; continued hospital visit implementation
	T: continued implementation of hospital visits
	W: finished hospital visit implementation
	R: refactors hospital implementation; started observers
Sep 5	M: Holiday
	T: Scoped out sbp/ldl-c hospital visits and treatment tasks; started hospital visit artifact
	W: finished artifact; began implementing hospital visits
	R: Spent some time debugging the outpatient_visits artifact data; mostly worked on CC presentation for monday
	F:
Aug 29	M: Implemented angina artifact, implementation, observer, post-processing
	T: finished angina; started v&v run
	W: finished most of heart failure
	R: finished heart failure, begain implementing incidence proportions
	F:
Aug 22	M: Implemented high sbp; trying to figure out if I'm using the correct (out of box) implementation of risk effect on incidence; started refactoring ldl-c observer and results to be generic
	T: finished sbp observers, post-processing
	W: sick
	R: git training, discussed how to implement exposure thresholds
	F: 
Aug 15	M: Implementing risk ldl-c, started adding observer
	T: Continued; lots of discussion/debugging into why we are getting negative exposures
	W: verified implementation is working (except for negatives and >10); wrote continuous ldlc exposure-time observer
	R: merged implementation and observer; added new exposure-time results; implemented ldl-c threshold [0,10]
	F: implemented artifact for high sbp; read docs
Aug 8	M: Finished model 1 MI and passed results to Syl
	T: Began implementing model 1 risk ldl-c
	W: Implementing risk factors, including needing to modify the standard artifact data due to having different names between source (gbd) and target (artifact), eg we use ischemic_stroke for acute_ and chronic_ischemic_stroke
	R: 
	F: validate w/ syl; work on stratifying risk ldl-c
Aug 1	M: Added most mycardial infarction to artifact and began MI modeling
	T: finished adding to artifact, implemented SourceTarget class for re-routing gbd causes to different output columns; los of meetings
	W: struggled with understanding event_counts all day
	R: so much debugging. PRed vph observer bug and then confirmed MI model 1 and PRed
	F: Working on observers; found that ylds for Post MI aren't making it into output
July 25	M: fixed dependency issue from repo tempate setup.py; merged model 1 causes; started model 1 DiseaseObserver; investigated doc build error (bug with Sphinx - created ticket); released vivarium, vph, and vivarium_inputs
	T: fought with make_results most of the day. Output.hdf columnnames vs results mapping column names
	W: DEI
	R: fixed up population for RT; customized ResultsStratifier to group ages 3-25.
	F: 
July 18	M: model 1 reading, beginning to implement
	T: finally finished adding ischemic stroke prevalence to artifact
	W: Finished IS artifact. Starting disease modeling
	R: Finished goals; figured out vs code remote develop/debugging; implemented IS disease model
	F: meetings; continued understanding IS diseasemodel
July 11	M: Start investigating Observers in CVD model0; changed approach to vivarium_inputs validation; confirmed sshing into node w/ allocated resources does not hold - Adam G confirmed, submitted a ticket, and CC confirmed it's a bug
	T: Meetings (design review, sprint planning); good progress on vivarium_inputs validation checking
	W: PR vivarium_inputs validation bugfix; fighting with Observers; added to MIC-3230 (bugs in research template)
	R: finished model0 observers; starting model0 psimulate
	F: got psimulate running
July 4	M: Holiday
	T: resolved conflict dependencies; doc reading; working on cvd model0
	W: Lots of time w/ Jim working on interactive simulations; wrapping up model 0 demographics
	R: starting to implement some of the repo template fixes found whild building cvd model 0; lots of time debugging `get_draws` expected columns
	F: Sick
June 27	M: finished videos; read docs + compass paper
	T: read CVD docs; messed with pycharm remote dev/debugging
	W: debuggede w/ Rajan; set up new cvd repo
	R: new pr template updates (and docs)
	F: Release a bunch of repos; fixed CODEOWNERS
