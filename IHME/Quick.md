
## household moves
pop = 200,000

first time step:
- pop: 199800x5 (household_id, relation_to_household_head, address_id, state, puma)
- units: 75765x3 (index = household_id, address_id, state, puma)
	- These are all unique households

### problem
- Finding non-unique state/puma for one address_id.