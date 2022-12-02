#cvd #heartfailure

# Heart failure

There's aproblem w/ heart failure: we would be double-counting mortalilty (some from ihd and some from heart failure,, some of which is also attributed to ihd)

Proposed solution: they will separate out heart failure from ihd (MI in the model). Doing so will require that simulants cannot have both

notes:
- Continue sending all ihd deaths into MI CSMR
- Then the RT will provide HF-specific csmr 
- We need to enforce all simulants to be only HF or IHD (cannot be both)
    - Initialization may be tricky
- In a nutshell, anyone in post- or acute-MI state cannot transition into HF
    - We will need to modify the transition rate to be zero
    - Ie if you have MI, you cannot have heart failure and vice versa (if you have heart failure you cannot ever get MI)

#cvd #heartfailure 