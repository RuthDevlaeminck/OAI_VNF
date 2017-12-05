#!/bin/bash

if [ -f "$SCRIPTS_PATH/func.sh" ]; then
        source $SCRIPTS_PATH/func.sh
else
        >&2 echo "$SERVICE: Could not find functions file $SCRIPTS_PATH/func.sh!"
        exit 1
fi

source_defaults_file 

echo "127.0.1.1       $hostname.3gppnetwork.org $hostname" >> /etc/hosts

MGMT_INTERFACE=$(getInterfaceName 1)
SIGNAL_INTERFACE=$(getInterfaceName 1)

create_interface_config_file "$SIGNAL_INTERFACE" >> $LOGFILE 2>&1

mkdir $LOG_DIR
source_generic_service_file "oaispgw" "install" "$SIGNAL_INTERFACE" "$MGMT_INTERFACE" "$mgmt_oa" >> $LOGFILE 2>&1
update_config_file "SGW_INTERFACE_NAME_FOR_S11              = \"lo\"; " "SGW_INTERFACE_NAME_FOR_S11              = \"$SIGNAL_INTERFACE\"; " $ETC_TARGET/spgw.conf   >> $LOGFILE 2>&1
update_config_file "SGW_IPV4_ADDRESS_FOR_S11                = \"127.0.11.2\/8\";" "SGW_IPV4_ADDRESS_FOR_S11                = \"$mgmt_oa\/8\";" $ETC_TARGET/spgw.conf   >> $LOGFILE 2>&1


echo "finished install script"
echo "finished install script" >> $LOGFILE 2>&1


