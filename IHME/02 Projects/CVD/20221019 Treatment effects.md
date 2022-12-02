We have two things going on: initialization and transitions

# Initialization
- On initialization, we already have treatment, type of treatment, adherence, and raw sbp values
- What we're missing is the multiplier and untreated sbp

Currently sbp exposure pipeline is outputting raw sbp. Need it to output sbp (by having its source be untreated sbp with a value modifier on sbp exposure where we subtract some value based on the csv Syl provided)

Treatment component shold manage the multiplier - make new columns for each of the multipliers - this column is immutable

Proposal: SBPRisk component creates a new pipeline "raw_sbp_exposure"
- It will 

#cvd #treatment 