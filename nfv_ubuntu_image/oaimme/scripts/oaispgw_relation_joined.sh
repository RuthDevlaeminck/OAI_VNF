#!/bin/bash

if [ -f "$SCRIPTS_PATH/func.sh" ]; then
        source $SCRIPTS_PATH/func.sh
else
        >&2 echo "$SERVICE: Could not find functions file $SCRIPTS_PATH/func.sh!"
        exit 1
fi

source_defaults_file 

update_config_file "SGW_IPV4_ADDRESS_FOR_S11                = \"127.0.11.2\/8\"" "SGW_IPV4_ADDRESS_FOR_S11                = \"$oaispgw_mgmt_oa\/8\"" $ETC_TARGET/mme.conf
