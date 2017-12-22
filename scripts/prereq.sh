#!/bin/bash

THIS_SCRIPT_PATH=$(dirname $(readlink -f $0))

source $THIS_SCRIPT_PATH/../build/tools/build_helper

source $THIS_SCRIPT_PATH/../build/tools/build_helper2

function help()
{
  echo_error " "
  echo_error "Usage: prereq.sh [<mysql root password> <hss db password>]"
  echo_error "If no values are entered the mysql password will not be set and phpmyadmin will not be installed"
}

if [ "$#" -gt 0 ] && [ "$1" = "-h" ]; then
  help
  exit
fi

INSTALL_PHPMYADMIN=0

if [ "$#" -eq 2 ]; then
  INSTALL_PHPMYADMIN=1

  # and since we don't want to have to enter the gui for phpmyadmin
  echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
  echo "phpmyadmin phpmyadmin/app-password-confirm password $2" | debconf-set-selections
  echo "phpmyadmin phpmyadmin/mysql/app-pass password $2" | debconf-set-selections
  echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections
fi

export  DEBIAN_FRONTEND=noninteractive

check_install_software $INSTALL_PHPMYADMIN

if [ "$#" -eq 2 ]; then
  mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$1'"
fi
