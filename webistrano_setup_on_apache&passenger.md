###Install Webistrano on CentOs with Apache

####Pre-requisites

Ruby and Ruby on Rails needs to be installed. See Install Ruby and RoR. Also, the appropriate database connector needs to be installed.
Apache needs to be installed. This guide will take you through the process of installing Phusion Passenger  but Apache should be installed before starting this process. 


####Setting up Webistrano

Download Webistrano to a suitable directory. The directory used on system is: 

    /home/webistrano

The easiest method to download is to use git with the following command in /home:

    sudo git clone git clone git://github.com/peritor/webistrano.git 

####Create database

Next, create a database for webistrano.

    mysql -u root -p *******
    create database webistrano;

####Configure Webistrano

In the webistrano directory (/home/webistrano) go into the config subdirectory. In here there should be two files, database.yml.sample and webistrano_config.rb.sample.

Open database.yml.sample in your preferred editor and locate the line

    production:

If you have a standard MySQL installation on CentOs and created the user and database in the previous step, the settings should look like:

    production:
     adapter: mysql2
     database: copy_web
     username: root
     password: 06mbMnVP3webi292012
     socket: /var/lib/mysql/mysql.sock

Make any required changes to reflect your actual database settings and save this file as database.yml.

Next, open webistrano_config.rb.sample. This is a ruby script that performs some configuration. It doesn't require much changes. The following is what the file looks like in one of our standard installs:

   
    WebistranoConfig = {

      # secret password for session HMAC
      :session_secret => 'shheujeuiruefnkdkssdjfndsjfuuejekks',

      # Uncomment to use CAS authentication    
      # :authentication_method => :cas,

      # SMTP settings for outgoingemail
     :smtp_delivery_method => :sendmail,

     # :smtp_settings => {
     #   :address  => "smtp.gmail.com",
     #   :port  => 587, 
     #   :domain  => "localhost",
     #   :user_name  => "shrikant@weboniselab.com",
     #   :password  => "passwd12",
     #   :authentication  => :plain    
     # },
     # Sender address for Webistranoemails
      :webistrano_sender_address => "webistrano@example.com",

      # Senderand recipient for Webistrano exceptions
      :exception_recipients => "team@example.com",
      :exception_sender_address => "webistrano@example.com"

    }
  
####Install Phusion Passenger

    sudo gem install passenger
or, if system already installed with passenger then, 

    sudo gem update passenger

Next, install the passenger apache module:

    sudo passenger-install-apache2-module

follow the instructions and edit your Apache configuration file, and add various lines in appropriate sections. Remember that your passenger config may be different. Use the recommended config from the output of the passenger install (the previous command)

Now, open /etc/hhtpd/conf/httpd.conf file and make entry of passenger load module in appropriate section: 

    LoadModule passenger_module /opt/ruby-enterprise-1.8.7-2011.03/lib/ruby/gems/1.8/gems/passenger-3.0.5/ext/apache2/mod_passenger.so
    PassengerRoot /opt/ruby-enterprise-1.8.7-2011.03/lib/ruby/gems/1.8/gems/passenger-3.0.5
    PassengerRuby /opt/ruby-enterprise-1.8.7-2011.03/bin/ruby

###Set up Webistrano VirtualHost site

Once Passenger has been installed and set up, serving up the webistrano application is fairly simple. With your favourite editor, create the file: 

    /etc/httpd/conf/httpd.conf

and create a virtual host specification, like 

    NameVirtualHost *:80

    <VirtualHost *:80>
       ServerName snakes.weboniselab.com
       DocumentRoot /home/webnowa/webistrano_workingwithuser/public/
       <Directory /home/webnowa/webistrano_workingwithuser/public/>
         #Options ExecCGI Indexes FollowSymLinks
         AllowOverride all
         Order allow,deny
         Allow from all
       </Directory>
      RailsEnv production
    </VirtualHost>

This will make Webistrano available on port 80 of your server. You then enable this site and restart apache:


    sudo apache2ctl restart

Webistrano should now be available on your server. 

