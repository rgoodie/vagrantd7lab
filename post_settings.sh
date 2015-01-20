# cd to root 
cd /var/www/drupal7

# we want module_filter, coffee, and devel
drush dl -y coffee module_filter devel module_builder
drush en -y coffee module_filter devel module_builder

# kill overlay
drush dis overlay -y

cd -
