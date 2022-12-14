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

What happend was
1. created `base_observer` class feature branch
2. pushed various `feature` and `bugfix` commits to it
3. branched off of the working `base_observer` to create a new feature branch `household_survey_observer`
4. pushed various features and bugfixes to it
5. merged `base_observer` to `main` (ie, released it for use)

I was left with a `household_survey_observer` branch that I wanted to either merge `main` into or  rebase it onto `main`. I did that by:
1. `git checkout household_survey_observer`
2. `git rebase main`
	NOTE: If there are no merge conflicts, this will fast-forward and all will be well. But...
3. Fix merge conflict as necessary
	1. `git add <fixed-file>`
	2. `git rebase --continue`
4. `git rebase --skip` as necessary
5. Repeat #3 and 4 until entire history is finished
6. `git push -f` if necessary and appropriate. 
	NOTE: Be careful not to `git pull` the main branch back b/c that would undo the stuff you just did





#Learning/Workflows #Learning/Commands 