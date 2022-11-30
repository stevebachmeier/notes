Launching
1. `jupyter lab`
2. Copy the link (eg https://int-uge-archive-p012:8890/)
3. Paste and modify like https://int-uge-archive-pXXX.cluster.ihme.washington.edu:8890
    1. password: thefutureisnow

Installing/setting up
1. Go to environment of interest
2. If missing, `mkdir .jupyter`
3. If missing, `mkdir notebooks`
4. `pip install jupyter`
5. `pip install jupyterlab`
6. If missing, `touch .jupyter/jupyter_notebook_config.py`
7. Add necessary config settings
8. Set up keys with `openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mycert.pem -out mycert.pem`

	
	

