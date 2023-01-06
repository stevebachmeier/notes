
## household moves
pop = 200,000

first time step:
- pop: 199800x5 (household_id, relation_to_household_head, address_id, state, puma)
- units: 75765x3 (index = household_id, address_id, state, puma)
	- These are all unique households

### problem
- Finding non-unique state/puma for one address_id.
	- The original moving_units object before the merge is 74174x1 (with the index, household_id, being completely unique)
	- The new `units` object is 75765x3 with duplicated household_ids.
		- If I remove the dupes it's the expected 74174 long
		- 


``` python
import pandas pd
```

