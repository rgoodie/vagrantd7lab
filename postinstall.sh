cd /var/www/drupal7
drush dis overlay -y
drush en og -y
drush en og_access -y
drush en node_export -y
drush en features ftools -y
drush en coffee -y
drush en module_filter -y
drush en devel -y

drush cc all 
drush cron

