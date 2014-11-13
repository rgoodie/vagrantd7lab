# Configure MySQL root password
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password root'

# Install packages
apt-get update
apt-get -y install mysql-server-5.5 php5-mysql libsqlite3-dev apache2 php5 php5-dev php5-gd build-essential php-pear 

# Set timezone
echo "Chiago/New_York" | tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

# Setup database
echo "DROP DATABASE IF EXISTS test" | mysql -uroot -proot
echo "CREATE USER 'drupal7'@'localhost' IDENTIFIED BY 'root'" | mysql -uroot -proot
echo "CREATE DATABASE drupal7" | mysql -uroot -proot
echo "GRANT ALL ON drupal7.* TO 'drupal7'@'localhost'" | mysql -uroot -prootv
echo "FLUSH PRIVILEGES" | mysql -uroot -proot

# Apache changes
# add line to end of conf file
echo "<Directory /var/www/drupal7>" >> /etc/apache2/apache2.conf
echo "      Options Indexes FollowSymLinks" >> /etc/apache2/apache2.conf
echo "      AllowOverride All" >> /etc/apache2/apache2.conf
echo "      Require all granted" >> /etc/apache2/apache2.conf
echo " </Directory>" >> /etc/apache2/apache2.conf
echo "ServerName localhost" >> /etc/apache2/apache2.conf
echo "User vagrant" >> /etc/apache2/apache2.conf
echo "Group vagrant" >> /etc/apache2/apache2.conf
a2enmod rewrite
# rewrite default.conf from provided source (nfs-linked to host)
cat /var/custom_config_files/apache2/default | tee /etc/apache2/sites-available/000-default.conf

# Install Mailcatcher
#echo "Installing mailcatcher"
#gem install mailcatcher --no-ri --no-rdoc
#mailcatcher --http-ip=192.168.33.20

# Configure PHP
sed -i '/;sendmail_path =/c sendmail_path = "/usr/local/bin/catchmail"' /etc/php5/apache2/php.ini
sed -i '/display_errors = Off/c display_errors = On' /etc/php5/apache2/php.ini
sed -i '/error_reporting = E_ALL & ~E_DEPRECATED/c error_reporting = E_ALL | E_STRICT' /etc/php5/apache2/php.ini
sed -i '/html_errors = Off/c html_errors = On' /etc/php5/apache2/php.ini

# Make sure things are up and running as they should be (generates warning if port in use...)
service apache2 restart

# install drush (just apt-get for the version we need to install Drupal 7)
apt-get -y install drush

# echo "downloading drupal 7 with drush.  Untarring takes a long time.  Go for a walk..."
cd /var/www/
drush dl drupal-7

### drush dl leaves an unpacked dir which I want to rename
mv dru* drupal7

# add porgie and tirebiter (if you gotta ask you don't need to know....)
 cp /var/scripts/porgie.php /var/www/drupal7/porgie.php
 cp /var/scripts/tirebiter.php  /var/www/drupal7/tirebiter.php

 mkdir     /var/www/drupal7/sites/default/files
 chmod 777 /var/www/drupal7/sites/default/files

cp /var/www/drupal7/sites/default/default.settings.php /var/www/drupal7/sites/default/settings.php
chmod 777 /var/www/drupal7/sites/default/settings.php


# install drupal 7 w drush, with db creds above
cd /var/www/drupal7
drush -y site-install standard --db-url='mysql://drupal7:wwsf2wstwv@localhost/drupal7' --site-name="drupal7 Lab"  --account-name=admin --account-pass=admin

# coffee
drush dl coffee module_filter devel -y


# Vim, Curl
apt-get install vim curl -y
