# Discussion: branch protections
Each repo and branch will need different protections

## Framework repo's `develop` branch
The following should be checked:
- PR required: 
	- main and long-standing
	- Turn on approvals (1 or 2)
	- turn on most recent push approval
- Require status checks before merging. 
	- Add the four build actions.
- Require signed commits
- Require linear history
- Do no allow bypassing of the settings
	- in a critical/time sensitive event, we are all admins and so can go in and remove this temporarily

Other notes:
- do not enforce conversation resolution - too prescriptive.
- We may not want to require linear history for `main`. We haven't been doing this historically.
- Enforcing successful deployments will not work for us
