Refer to the "risk factors overview" training video at I:\GBD Trainings and Recordings\2020 GBD Cycle trainings\Risk Factors Overview 1.22.2020\

**Risk factor**: any exposure that leads to a loss of health in population; a variable associated with an increased risk of disease or infection

# Relative risks
The ratio of the probability of an outcome in an exposed group to the probability of an outcome to an unexposed group
- That is, for each unit of exposure to a given risk factor, what is the change of each associated outcome?
Three types:
- Continuous. Eg systolic blood pressure.
- Dichotomous (binary, "yes" or "no"). Eg vitamin A deficiency
	- NOTE: can also classify/bin a continuous exposure, eg occupational exposure to noise (in dB) is classified as "unexposed" (<95) or exposed (>95)
- Polytomous (categorical(). Eg unsafe water

NOTE: relative risk = 1 --> no increased risk
NOTE: a relative risk can be protective and have a value < 1

# Exposure
**The actual values of the risk, eg mmol/L of LDL-C.**
Data sources include: household surveys, administrative data, census, environmental measurements. Etc
Modling; most exposure modeling occurs in DisMod and ST-GPR. 

# Theoretical Minimum Risk Exposure Level (TMREL)
This is the lowest exposure level which results in the lower distribution of risk facter every observed in any population. Examples:
-  Intimate partner violence: no exposure over lifetime
- Diet low in fruits: Consumption between 200-400 grams/day
- Diet high in sodium: 1-5 grams/day
- High bmi: 21-23 BMI
- Unsafe sex: no exposure to disease agent through sex
- Water and sanitation: Piped water supply w/ treatment and toilet w/ sewer connection

# Population Attributable Fractions (PAF)
PAF is the proportion of incidents in the population that are attributable to the risk factor
- Eg, from the IHME viz tool looking at the smoking risk on global all-age all-sex DALY's in 2017, we see that the PAF for lung cancer is 61.31%. This means that if everyone in the world was at the TMREL for smoking (ie, did not smoke), 61.31% of lung cancer DALYs would be eliminated.

NOTE: you can have PAFs add up to more than 100%

Joint PAF: a combined PAF to account for the burden of multiple risk factors
PAF_1…i = 1 - SUM_i=1_to_n (1 - PAF_i)
- Where I is an individual risk factors
- Assumes that PAFs are independent
- Total PAF will be < 1

#Learning/Definitions