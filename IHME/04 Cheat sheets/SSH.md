To get access to another service (e.g. github, stash) or another user (eg svccovidci):
1. Copy my public key /.ssh/id_rsa.pub
2. Paste my public key to the service's /.ssh/authorized_keys

## Example 1.
Adding my local computer to my cluster account so I can ssh in to the cluster w/o providing a password every time
1. Add the following to /Users/sbachmei/.ssh/config. This allows (1) the ssh key to be used instead of a password (IdentityFile) and (2) not have to type "yes" I want to connect to the host every time (StrictHostKeyChecking no)
    Host *.ihme.washington.edu
        IdentityFile /Users/sbachmei/.ssh/id_rsa
        User sbachmei
        ForwardAgent yes
    Host *
        StrictHostKeyChecking no
        ServerAliveInterval 120
2. Create an ssh key pair on sbachmei@Steves-MacBook-Pro
3. Copy the value in /Users/sbachmei/.ssh/id_rsa.pub
4. Ssh onto the cluster and paste that value into /ihme/homes/sbachmei/ssh/authorized_keys

## Example 2
Being given access to a service user svccovidci.
1. Copy the cluster public key from /ihme/homes/sbachmei/.ssh/id_rsa.pub
2. Having someone w/ access to the user (ie infra) to add that public key to the service user's authorized_keys file at /ihme/homes/svccovidci/.ssh/authorized_keys

#Learning/Workflows 