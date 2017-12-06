#!/bin/bash

if [ -f "$SCRIPTS_PATH/func.sh" ]; then
        source $SCRIPTS_PATH/func.sh
else
        >&2 echo "$SERVICE: Could not find functions file $SCRIPTS_PATH/func.sh!"
        exit 1
fi

source_defaults_file

echo "$oaihss_mgmt_oa       hss.openair4G.eur   hss" >> /etc/hosts

update_config_file "ConnectTo = \"127.0.0.1\"" "ConnectTo = \"$oaihss_mgmt_oa\"" $ETC_TARGET/freeDiameter/mme_fd.conf
