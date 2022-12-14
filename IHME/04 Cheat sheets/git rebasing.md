Example use case: for the vivarium prl project, we don't have a `develop` branch but instead we create develop-like feature-specific branches which we then push different features, bugfixes, etc to. Then when the feature is finished, we merge to main.

1. created `base_observer` class feature branch
2. pushed various `feature` and `bugfix` commits to it
3. branched off of `base_observer` to create a new feature branch `household_survey_observer`
4. pushed various features and bugfixes to it

Now that the `base_observer` is done, I opened a PR and am ready to merge into main.
But then I need to rebase `household_survey_observer` to `main` (I think?)



#Learning/Workflows 