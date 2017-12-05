#!/bin/bash

if [ -f "$SCRIPTS_PATH/func.sh" ]; then
        source $SCRIPTS_PATH/func.sh
else
        >&2 echo "$SERVICE: Could not find functions file $SCRIPTS_PATH/func.sh!"
        exit 1
fi

source_defaults_file

echo "127.0.1.1       hss.openair-cn.3gppnetwork.org   hss" >> /etc/hosts
echo "127.0.1.1       $hostname" >> /etc/hosts

create_interface_config_file "ens4" >> $LOGFILE 2>&1

source_generic_service_file "oaihss" "install" >> $LOGFILE 2>&1

echo "finished install script"
echo "finished install script" >> $LOGFILE 2>&1


