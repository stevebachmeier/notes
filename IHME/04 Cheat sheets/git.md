```toc

```

# Rebasing
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

## Example workflow
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
This one is scary.

## Example workflow
Refer to the example above in the [Example workflow](#Example%20workflow) section. I was left with a shiny new `main` branch with a ready-to-use BaseObserver class as well as a `household_survey_observer` feature branch to develop on that was rebased on `main`. The problem was that I had already done work on the a `feature/survey` branch that needed to be rebased to the (new) `household_survey_observer` feature branch. 

One option is to merge. Another is to go through the exact same thing as before and rebase. A third is to hard reset to wipe away the commit history and *then* rebase. That's what I chose.
1. `git checkout feature/survey`
2. Stash any uncommited work.
3. `git reset --soft HEAD~N` the N new commits on this feature branch.
4. Stash those new commits.
5. `git reset --hard HEAD~M` some number of commits (M) to ensure I wipe out enough history to not cause merge conflicts when I rebase. It can be any arbitrarily large number (ie you can wipe out the entire history) since you're rebase and get it all back.
6. `git rebase household_survey_observer`
	NOTE: This should result in a perfectly clean rewind/fastforward.
7. `git push -f` if necessary and appropriate



#Learning/Workflows #Learning/Commands 