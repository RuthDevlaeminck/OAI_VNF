#!/bin/bash

if [ -f "$SCRIPTS_PATH/func.sh" ]; then
        source $SCRIPTS_PATH/func.sh
else
        >&2 echo "$SERVICE: Could not find functions file $SCRIPTS_PATH/func.sh!"
        exit 1
fi

source_defaults_file 

SIGNAL_INTERFACE=$1
SIGNAL_IP=$2

cp $OPENAIRCN_ETC/mme.conf $ETC_TARGET
cp $OPENAIRCN_ETC/mme_fd.conf $ETC_TARGET/freeDiameter

update_config_file "MME_INTERFACE_NAME_FOR_S1_MME         = \"enp0s8\";" "MME_INTERFACE_NAME_FOR_S1_MME         = \"$SIGNAL_INTERFACE\";" $ETC_TARGET/mme.conf 
update_config_file "MME_IPV4_ADDRESS_FOR_S1_MME           = \"192.168.11.17\/24\";" "MME_IPV4_ADDRESS_FOR_S1_MME           = \"$SIGNAL_IP\/24\";" $ETC_TARGET/mme.conf
update_config_file "yang" "$hostname" $ETC_TARGET/freeDiameter/mme_fd.conf
update_config_file "MCC=\"208\"" "MCC=\"$MCC\"" $ETC_TARGET/mme.conf
update_config_file "MNC=\"93\"" "MNC=\"$MNC\"" $ETC_TARGET/mme.conf
update_config_file "MME_GID=\"4\"" "MME_GID=\"$MME_GID\"" $ETC_TARGET/mme.conf
update_config_file "MME_CODE=\"1\"" "MME_CODE=\"$MME_CODE\"" $ETC_TARGET/mme.conf
update_config_file "TAC = \"1\"" "TAC=\"$TAC\"" $ETC_TARGET/mme.conf
update_config_file "ORDERED_SUPPORTED_INTEGRITY_ALGORITHM_LIST = \[ \"EIA2\" , \"EIA1\" , \"EIA0\" \];" "ORDERED_SUPPORTED_INTEGRITY_ALGORITHM_LIST = [ $INT_ALG_LIST ];" $ETC_TARGET/mme.conf
update_config_file "ORDERED_SUPPORTED_CIPHERING_ALGORITHM_LIST = \[ \"EEA0\" , \"EEA1\" , \"EEA2\" \];" "ORDERED_SUPPORTED_CIPHERING_ALGORITHM_LIST = [ $CIPH_ALG_LIST ];" $ETC_TARGET/mme.conf

cd $OPENAIRCN_SCRIPTS
./check_mme_s6a_certificate $ETC_TARGET/freeDiameter $hostname.openair4G.eur


install_service_file "mme"

