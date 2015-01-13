# cd to root 
cd /var/www/drupal7

# we want module_filter, coffee, and devel
drush dl -y coffee module_filter devel
drush en -y coffee module_filter devel

# kill overlay
drush dis overlay -y

cd -
