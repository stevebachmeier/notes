Two main changes: hf and change to ihd

Heart failure:
- HF is remaining a simple SI model
- The states data are gbd data then ultiplied by proportions
    - The HF model is being knocked down to "residual" HF (ie not IHD HF)
    - The remaining stuff is HF from IHD
- Some of the stuff is not in GBD (prevalence, relative risks, etc)
- DWs should pull from gbd like normal
- Post-processing: at the end of the sim, we're going to proportion out the HF numbers into hyper-tensive HF and other HF (using another proportions file)
    - This kinda makes two new causes

IHD:
- Need to remember that if a person has HF and then has a heart attack, they need to go bavck to HF. 
    - This is why there is a separate AMI_HF block - not sure if that's needed or not
- The heart failure HF box here is HF due to IHD. 
    - We use prevalences of HR from IHD
- They actually have all of the HF sequelae but there are loads of them
    - This is why they opted to do the proportion file thing
- NOTE: The CSMR equatio is different

Rajan's comments
- She should probably add the HR model into the IHD one
    - This would ensure a person can't have other HF AND IHD (which is probably the way we want this)
- Should consider scaling EMR down to get CSMR HF to better match gbd

TODO:
- Since HF is still in flux, other options to work on when I get stuck are:
    - PRL onboarding - prl repo/docs/Vivarium Synth Pop.docx
        § There's a non-trivial chance that we're going to pause cvd in December and move me to PRL
            □ Why? B/c PRL is higher priority and we're behind
    - Backlog tickets
