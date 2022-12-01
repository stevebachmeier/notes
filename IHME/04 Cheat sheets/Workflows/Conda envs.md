Installing miniconda from scratch
1. Log onto cluster
2. `wget  https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh`
3. `bash Miniconda3-latest-Linux-x86_64.sh`
    1. Accept all defaults (or consider installing miniconda to `/ihme/code/<username>`)
    2. Accept the `conda init` the installer offers to do

As an example, let's create a new `covid_released` env from scratch to mimic Jenkins (refer to covid-snapshot-etl-orchestration/snapshot-etl.sh)
1. (optional) `conda env remove -n covid_released`
2. `conda create -y --name=covid_released python=3.7`
3. `conda activate covid_released`
4. `pip install -e ~/repos/covid-shared/`
5. `conda install -y -c hcc rclone unzip`
6. `pip install -e ~/repos/covid-input-snapshot/ --extra-index-url https://artifactory.ihme.washington.edu/artifactory/api/pypi/pypi-shared/simple/`
7. `pip install -e ~/repos/covid-input-etl/ --extra-index-url https://artifactory.ihme.washington.edu/artifactory/api/pypi/pypi-shared/simple/`

	
E.g. create fresh covid env
1. `conda create -y --name=covid python=3.7`
2. `conda activate covid`
3. `pip -e install ~/repos/covid-shared/`
4. `conda install -y -c hcc rclone unzip`
5. `pip install -e ~/repos/covid-input-snapshot/ --extra-index-url https://artifactory.ihme.washington.edu/artifactory/api/pypi/pypi-shared/simple/`
6. `pip install -e ~/repos/covid-input-etl/ --extra-index-url https://artifactory.ihme.washington.edu/artifactory/api/pypi/pypi-shared/simple/`
7. `pip install beautifulsoup4 matplotlib notebook pydeps pylint pytest viztracer`
