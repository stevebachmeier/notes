Docs (out of date): https://ihmeuw.github.io/vivarium_development/docs/build/html/process_tutorials/performing_a_release.html

## Basic strategy:
- Release in the order specified in the docs
- recommended to run through the entire procedure one repo at a time (in the order specified in the docs)
- NOTE: Do NOT run `vadmin make releaser` like the docs say (a github update ruined that)

1. Make sure all relevant PRs are merged 
    - No need to release if there is no diff between `develop` and `main`
2. Run `pytest` on the repo being released
3. Follow the rest of the procedure in the docs:
    1. Compare HEAD (develop) to previous release (main). One way is to start a PR of develop -> release vx.xx.xx and look at the diff
    2. Directly on the develop branch:
        1. Update CHANGELOG.rst
        2. Update version in __about__.py
        3. Update upstream dependencies in setup.py
        4. Commit and push to develop
    3. Wait for automated tests to clear (python 3.6, 3.7, 3.8)
    4. Merge to main (do not need to get approvals)
    5. Click the "draft new release" button, give it the correct version, click "generate release notes"

#Learning/Workflows 