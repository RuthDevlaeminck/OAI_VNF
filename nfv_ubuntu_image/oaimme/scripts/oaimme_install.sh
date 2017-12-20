#!/bin/bash

if [ -f "$SCRIPTS_PATH/func.sh" ]; then
        source $SCRIPTS_PATH/func.sh
else
        >&2 echo "$SERVICE: Could not find functions file $SCRIPTS_PATH/func.sh!"
        exit 1
fi

source_defaults_file

download_and_build_oai >> $LOGFILE 2>&1

echo "127.0.1.1       $hostname.openair4G.eur $hostname" >> /etc/hosts

#using only one interface for lxd containers
SIGNAL_INTERFACE=$(getInterfaceName 1)
#SIGNAL_INTERFACE=$(getInterfaceName 2)
SIGNAL_IP=$mgmt_oa

#create_interface_config_file "$SIGNAL_INTERFACE" >> $LOGFILE 2>&1

mkdir $LOG_DIR

source_generic_service_file "oaimme" "install" "$SIGNAL_INTERFACE" "$SIGNAL_IP" >> $LOGFILE 2>&1

if [ "$hss_ip" != "" ]; then
  echo "$hss_ip       hss.openair4G.eur   hss" >> /etc/hosts
  update_config_file "ConnectTo = \"127.0.0.1\"" "ConnectTo = \"$hss_ip\"" $ETC_TARGET/freeDiameter/mme_fd.conf
fi
update_config_file "MME_INTERFACE_NAME_FOR_S11_MME        = \"lo\";" "MME_INTERFACE_NAME_FOR_S11_MME        = \"$SIGNAL_INTERFACE\";"  $ETC_TARGET/mme.conf  >> $LOGFILE 2>&1
update_config_file "MME_IPV4_ADDRESS_FOR_S11_MME          = \"127.0.11.1\/8\";" "MME_IPV4_ADDRESS_FOR_S11_MME          = \"$SIGNAL_IP\/8\";" $ETC_TARGET/mme.conf >> $LOGFILE 2>&1

echo "finished install script"
echo "finished install script" >> $LOGFILE 2>&1


