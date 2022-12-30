Launching
1. `jupyter lab`
2. Copy the link (eg https://int-uge-archive-p012:8890/)
3. Paste and modify like https://int-uge-archive-pXXX.cluster.ihme.washington.edu:8890
    1. password: thefutureisnow

Installing/setting up
1. Go to environment that has jupyter and jupyterlab installed (this is *required*; the central comp script will *not* default to a central env). If needed:
	1. `pip install jupyter`
	2. `pip install jupyterlab`
2. If missing, `mkdir .jupyter`
3. If missing, `mkdir notebooks`
4. If missing, `touch .jupyter/jupyter_notebook_config.py`
```
# Not to launch a browser on the jupyter server node
c.NotebookApp.open_browser = False
# Disable token authentication
c.NotebookApp.token = ''
# Disable password authentication
c.NotebookApp.password = ''
# Bind all ips
c.NotebookApp.ip = '*'
# Set default working directory
c.NotebookApp.notebook_dir = u'/mnt/share/homes/sbachmei/notebooks/'
# Set cert file
c.NotebookApp.certfile = u'/mnt/share/homes/sbachmei/notebooks/mycert.pem'
```
5. Set up keys: `openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mycert.pem -out mycert.pem`

#Learning/Workflows 