# Commands
| command            | description          | flags                                                                                                                                                                                                               | example                                                                                                                |
| ------------------ | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| `du <path>`        | disk usage           | -s summarize, -c produce total, -h human readable, -d max depth                                                                                                                                                     | `du -shc /var/*`; `du -hc -d 0 /var/* \| sort -rh \| head -5`                                                          |
| `df <path>`        | disk free            |                                                                                                                                                                                                                     |                                                                                                                        |
| `touch <filename>` | create a new file    |                                                                                                                                                                                                                     |                                                                                                                        |
| `vim filename`     | open file in vim     |                                                                                                                                                                                                                     |                                                                                                                        |
| `ls`               | list dir contents    | -a all (includes . files); -d directories only; -l long listing, -R recursive; -S sort by file size, -t sort by modification time newest first, -l long (list permissions), -t sort by date/time, -h human readable |                                                                                                                        |
| `find`             | search for a file    | -name by name, case sensitive; -iname not case sensitive                                                                                                                                                            | `find PATH/TO/DIRECTORY/ -type d -exec chmod 775 {} \;`; `find PATH/TO/DIRECTORY/ -type f -exec chmod 664 {} \;`       |
| `rmdir`            | delete an empty dir  |                                                                                                                                                                                                                     |                                                                                                                        |
| `rm`               | delete               | -r recursive (rm dir)                                                                                                                                                                                               |                                                                                                                        |
| `ln <src> <trgt>`  | create symbolic link | -n no dereference; -f force (remove existing destination files); -s symbolic instead of hard links                                                                                                                  | `ln -nfs <onedrive_folder> <snapshot_folder>/covid_onedrive`                                                           |
| `cp <src> <dest>`  | copy                 | -r, R: recurseive                                                                                                                                                                                                   | ` cp -r /ihme/covid-19/snapshot-data/best/covid_onedrive/ ~/scratch/snapshots/`                                        |
| `scp`              | copy over ssh        |                                                                                                                                                                                                                     | `scp sbachmei@cluster-submit1.ihme.washington.edu:~/scratch/deaths_cases_hospitalizations_2021_03_15.01.pdf ~/scratch` |


# Permissions (UGO)
User / group / other
File (-) or folder (d) / owner permissions / group permissions / world permissions
- Owner (u): who owns the file, has control over access. 
- Group (g): specific group of users who can access the file
- World (o): anyone who has access privileges to the system

## octal representation

Ex: `chmod 754 <filename>`
![](https://github.com/stevebachmeier/notes/blob/main/z_pictures/octal_representation.png)

![](../../zAttachments/Pasted%20image%2020221201202610.png)

#Learning/Commands
