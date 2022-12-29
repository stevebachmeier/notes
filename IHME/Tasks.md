 [Weekly retro](Weekly%20retro.md)

- [ ] Add CA to prl artifact
- [ ] 

# Archived

- [[2022-12-W-49]]
	- [x] Double check new IHD + HF transition rate equations ✅ 2022-12-02
	- [x] [20221201](02%20Projects/CVD/Checkins/20221201.md) ✅ 2022-12-02
	- [x] 🔼 Review updated polypill docs ✅ 2022-12-02
	- [x] ⏫  PRL docs ✅ 2022-12-02
- [[2022-12-W-50]]
	- [x] Fix the first pytest failure by having the validation function throw an error ✅ 2022-12-06
	- [x] Fix second pytest vivarium_inputs error ✅ 2022-12-06
	- [x] Implement max BMI (refer to PR!) ✅ 2022-12-07
	- [x] [[01 Notes/Sprints.md#101]] ✅ 2022-12-07
- [[2022-12-W-52]]
	- [x] Update polypill implementation per doc change ✅ 2022-12-09
		- [x] Read all docs/PRs ✅ 2022-12-07
	- [x] Finish prl observer design ✅ 2022-12-13
	- [x] Build base observer class ✅ 2022-12-13
		- this is required to unblock Abie from working on the census observer
	- [x] Build household survey observer classes ✅ 2022-12-15
	- [x] Add `git rebase` notes to the hub 📅 2022-12-15 ✅ 2022-12-16
	- [x] Build out pytest suite for observers 📅 2022-12-15 ✅ 2022-12-16
	- [x] review mic-3349 (matt's pytests for resultsstratifier) ✅ 2022-12-15
	- [x] Finish implementing HouseholdSurveyObserver PR requested changes from Rajan ✅ 2022-12-20
		- refactor input_cols and output_cols as @abstractmethods
		- Add better pytest
- [[2022-12-W-53]]
	- [x] v&v household observer https://jira.ihme.washington.edu/browse/MIC-3671 ✅ 2022-12-27
		-  run on main (after Jim merges his thing)
		-  Run 3x `simulate runs` in parallel on the following pops: 25k, 250k, 2.5million
		-  Run w/ 100GB. This should be more than enough
		- Request 24hrs
		- [x] Profile the three sruns afterwards on slurmtools ✅ 2022-12-27
	- [x] Finish git hub doc https://jira.ihme.washington.edu/browse/MIC-3687 ✅ 2022-12-23
	- [x] Update repo CI builds for python 3.7-3.10 and remove Beatrix https://jira.ihme.washington.edu/browse/MIC-3690 ✅ 2022-12-29
	- [x] Fix isort/black failing on prl https://jira.ihme.washington.edu/browse/MIC-3713 ✅ 2022-12-29
	- [x] Design scale-up https://jira.ihme.washington.edu/browse/MIC-3681 ✅ 2022-12-29
