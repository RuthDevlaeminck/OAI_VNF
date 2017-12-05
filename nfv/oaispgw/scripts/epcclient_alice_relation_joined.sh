#!/bin/bash

if [ -f "$SCRIPTS_PATH/func.sh" ]; then
        source $SCRIPTS_PATH/func.sh
else
        >&2 echo "$SERVICE: Could not find functions file $SCRIPTS_PATH/func.sh!"
        exit 1
fi

source_defaults_file

#ESCAPED_CIDR=`echo $UE_CIDR | sed -e 's:/:\\\/:g'`
ESCAPED_CIDR="192.168.3.64\/26"
update_config_file "192.168.3.0\/24" "$ESCAPED_CIDR" $ETC_TARGET/spgw.conf
UE_MTU=1500
update_config_file "UE_MTU                                    = 1500" "UE_MTU                                    = $UE_MTU" $ETC_TARGET/spgw.conf

