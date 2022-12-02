# General outline
1. Pull gbd data for sbp exposure values
    1. "baseline_exposure"
2. Multiply adherent and medicated values by the multiplier in the docs
    1. Different multipliers for the different pill levels
    2. "untreated_exposure" - THIS WILL ACT AS THE SOURCE OF THE BLOOD PRESSURE EXPOSURE PIPELINE
3. The "untreated_exposure" will get acted upon by the treatment effect by adding values from the .csv docs she provided
    1. "true_exposure"

NOTES about this:
- When you age, the gbd value "baseline_exposure" will change - this will lead to a change in the "true_exposure"

# General approach
1. Modify Risk class
    1. Make lookup table of gbd sbp exposure data
    2. NOTE: it's currently implemented as a value pipeline that has as as source the lookup table. We want to expose the lookup table itself.
2. Make a new state table column of multipliers for each simulant
    1. In the Treatment class
    2. 1 for non-adherent/non-medicated, xxx for one pill, xxx for two pills
    3. NOTE: this stays the same throughout the sim b/c it ONLY adjusts the initial gbd data
3. Make an sbp exposure pipeline 
    1. The source should be a function (eg "get_untreated_sbp_exposure_value()" that calls the gbd lookup table and then multiplies it by the multiplier column
    2. Other components - eg the treatment effect - will be the value_modifier
    