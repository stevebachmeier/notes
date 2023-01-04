```toc

```

# Rebase
`git rebase` is the process of moving or combining a sequence of commits to a new base commit. Note that this solves the same problem as `git merge`; both commands integrate changes from one branch into another branch (just in different ways).

Rebasing looks like:
![](../zAttachments/01%20What%20is%20git%20rebase.svg)

Notes comparing merge to rebase:
| merge | rebase |
| --- | --- |
| `git checkout feature`; `git merge main` | `git checkout feature`; `git rebase main` |
| integrates changes from one branch into another | integrates changes from one branch into another |
| 👍 simpler | 👎 more complicated |
| non-destructive; it adds a new merge commit. | Destructive; rewrites the project history by creating branch new commits for each in the original branch |
| 👎 Can clutter the git log | 👍 Much cleaner |
|  |  |

## Workflow
Possibly the most common time to rebase a branch is when you're ready to open a PR to merge a `develop` branch into `main` . Assuming you want to merge `develop/some-feature` into `main` :
1.  `git checkout develop/some-feature` 
2.  Ensure the latest commit is buildable and all tests pass.
3.  Squash all of the branch's commits into a single one.
    -   Option: `git rebase -i HEAD~[NUMBER OF COMMITS]`
    -   Option: `git rebase -i 'git merge-base HEAD main'` 
        -   Note: The SHA of the last shared commit can be easily found with `git merge-base HEAD main`
4.  If the develop branch is already on the remote, force push (because the branches have diverged): `git push origin develop/some-feature --force-with-lease` 
	- **NOTE: Any forced push can be dangerous if others are working on the same branch since it rewrites history. The `--force-with-lease`  option protects against this but there are still some edge cases where it's possible to overwrite someone else's work.** 
5.  Pull any updates in main: `git checkout main` && `git pull origin main` 
6.  `git checkout develop/some-feature` 
7.  `git rebase main` 
8.  Resolve merge conflicts as necessary (if there are no merge conflicts, then git will automatically rewind/fastforward and all will be well)
    1.  Resolve merge conflict(s)
    2.  `git add [FIXED FILE(S)]` 
    3.  `git rebase --continue` 
9.  `git rebase --skip`  as necessary (for commits that do not have a merge conflict)
10.  Repeat steps 8-9 until the entire history is finished (should only be once assuming you squashed your commits)
11.  `git push origin develop/some-feature --force-with-lease`
12.  Merge `develop/some-feature` into `main`   
    -   Note: This merge may not need review if all of the work has already been approved via feature/bugfix PRs into the `develop/some-feature`  branch.
13.  Communicate that `main` has been updated.

### Example
Use case: for the vivarium prl project, we don't have a `develop` branch but instead we create develop-like feature branches which we then push different features, bugfixes, etc to. Then when the feature is finished, we merge to main.

What happened was
1. created `base_observer` class feature branch
2. pushed various `feature` and `bugfix` commits to it
3. branched off of the working `base_observer` to create a new feature branch `household_survey_observer`
4. pushed various features and bugfixes to it
5. merged `base_observer` to `main` (ie, released it for use)

I was left with a `household_survey_observer` branch that I wanted to either merge `main` into or  rebase it onto `main`. I did that by:
1. `git checkout main`
2. `git pull`
3. `git checkout household_survey_observer`
4. `git rebase main`
	NOTE: If there are no merge conflicts, this will fast-forward and all will be well. But...
3. Fix merge conflict as necessary
	1. `git add <fixed-file>`
	2. `git rebase --continue`
4. `git rebase --skip` as necessary
5. Repeat #3 and 4 until entire history is finished
6. `git push -f` if necessary and appropriate. 
	NOTE: Be careful not to `git pull` the main branch back b/c that would undo the stuff you just did

# Reset
This one is scary; `git reset` is another destructive git command that is used to undo previously committed work by resetting HEAD to some specified state.

## Workflow
**NOTE: `git reset`  also rewrites history and so can be dangerous!
1.  `git checkout develop/some-feature` 
2.  Soft reset the commits to squash. Note that the `--soft` argument is critical as it will undo and stage the commits rather than remove them altogether.
    -   Option: `git reset --soft HEAD~[NUMBER OF COMMITS]` 
    -   Option: `git reset --soft [SHA OF COMMIT YOU BRANCHED FROM]` 
        -   Note: The SHA of the last shared commit can be easily found with `git merge-base HEAD main`
3.  Stash the staged changes
4.  Move `develop/some-feature` to the tip of `main` .
    -   Option: `git rebase main` 
    -   Option: `git merge main` 
5.  Unstash the stashed work and commit. This results in that work from any number of previous commits beings squashed into this new commit.
6.  `git push --force-with-lease`

### Example
Refer to the example above in the [Example workflow](#Example%20workflow) section. I was left with a shiny new `main` branch with a ready-to-use BaseObserver class as well as a `household_survey_observer` feature branch to develop on that was rebased on `main`. The problem was that I had already done work on the a `feature/survey` branch that needed to be rebased to the (new) `household_survey_observer` feature branch. 

One option is to merge. Another is to go through the exact same thing as before and rebase. A third is to hard reset to wipe away the commit history and *then* rebase. That's what I chose.
1. `git checkout feature/survey`
2. Stash any uncommited work.
3. `git reset --soft HEAD~N` the N new commits on this feature branch.
4. Stash those new commits.
5. `git reset --hard HEAD~M` some number of commits (M) to ensure I wipe out enough history to not cause merge conflicts when I rebase. It can be any arbitrarily large number (ie you can wipe out the entire history) since you're rebase and get it all back.
6. `git rebase household_survey_observer`
	NOTE: This should result in a perfectly clean rewind/fastforward.
7. unstash any stashed work and commit them
8. `git push -f` if necessary and appropriate



#Learning/Workflows #Learning/Commands 