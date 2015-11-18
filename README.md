# vagrantd7lab
Create and provision a VM with LAMP, drush and Drupal 7 .  At the end of `vagrant up` you're left with a working copy of Drupal 7 sitting on Ubuntu. I use this for playing with new module ideas for D7. 

# Simple Configuration 
There is no configuration outside of the _Vagrant_ file which calls _bootstrap.sh_. There is an optional _post_settings.sh_ which can be run on in bash. Place any customizations you like here. Call `drush -y` to install or remove modules as you need. 
