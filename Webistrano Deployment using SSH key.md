## Project Deployment using Webistrano with the SSH public key authentication.
1. Login with the authorized user on a webistrano server using ssh.

        $ssh user@ip-address

2. Generate ssh key on Webistrano server

        $ssh-keygen -t rsa

   above command generates the public & private key in ~/.ssh/ folder

3. Copy a public key(generated in step2) on a server where project will deploy

        $ssh-copy-id -i ~/.ssh/id_rsa.pub user@remote-host

4. Login on remote host without entering password

        $ssh user@remote-host

   if not logged in? then, check whats the mistake you have done
   & troubleshoot it

5. After this we will use public key authetication for project deployment using Webistrano, here we are assuming accesing webistrano through port no. 80,
   so make sure your generated public key should ne accessible  by www-data user, to so this 

   Create .ssh dir in www-data user home dir
	
        $sudo mkdir /var/www/.ssh
   Copy public key from your home directory

        $cp ~/.ssh/id_rsa.pub /var/ww/.ssh/id_rsa.pub

6. Remove password field from project stages

7. Finally, try to deploy your project

###Troubleshoot

1.if you are getting authentication failed

then check,

make sure public key copied with the proper permission


2.If getting failed status with output as shown below

        *** can't convert nil into String
        *** /var/www/webistrano/lib/webistrano/extensions.rb:17:in `abort'
        *** /var/www/webistrano/lib/webistrano/extensions.rb:17:in `abort'
        .
        .
        *** /var/lib/gems/1.9.1/gems/rails-2.3.14/lib/commands/runner.rb:48:in `<top         (required)>'
        *** script/runner:3:in `require'
        *** script/runner:3:in `<main>'

Then check,

Your "deploy_to" directory should owned by deploying user(user mentioned in webistrano capfile to login on server)

To change ownership,
Login on server using ssh

        $ssh username@ip-address

To change ownership & group ownership

        $chown username:username "deploy_to directory path"

Now try to deploy
