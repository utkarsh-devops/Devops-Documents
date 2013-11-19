echo "This script requires superuser access to install packages."
echo "You will be prompted for your password by sudo."
 
# clear any previous sudo permission
sudo -k
 
# run inside sudo
sudo sh <<SCRIPT
	# installing apache
	echo ">>> Installing Apache2."
	apt-get install -y apache2
 
	# installing PHP and php-cli
	echo ">>> Installing PHP5 and related libraries."
	apt-get install -y php5 libapache2-mod-php5 php5-cli php5-mysql
 
	echo ">>> Installing Image magick and Php driver for Image Magick."
	apt-get install -y imagemagick 
	apt-get install -y php5-imagick	
 
	echo ">>> Installing Mysql Server and PHPMyAdmin."
	apt-get install -y mysql-server
	apt-get install -y phpmyadmin
 
	echo ">>> Installing Curl and libraries of Curl for PHP."
	apt-get install -y curl libcurl3 libcurl3-dev php5-curl
 
	echo ">>> Installing PEAR, and php related libraries for it."
	apt-get install -y php-pear
	apt-get install -y php5-dev
 
       	echo ">>> Installing Cake Script"
        apt-get install -y cakephp
 
        echo ">>>> Enabling Mod Rewrite"
        a2enmod rewrite
        service apache2 restart
	
	echo ">>> Installing GIT Core."
	apt-get install -y git-core
 
	echo ">>> Installing MongoDB."
	apt-get install -y mongodb
 
	echo "Updating the System"	
	apt-get update
SCRIPT
