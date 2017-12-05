#!/bin/bash

if [ -f "$SCRIPTS_PATH/func.sh" ]; then
        source $SCRIPTS_PATH/func.sh
else
        >&2 echo "$SERVICE: Could not find functions file $SCRIPTS_PATH/func.sh!"
        exit 1
fi

source_defaults_file

echo "$oaimme_mgmt_oa_floatingIp       $oaimme_hostname.openair-cn.3gppnetwork.org   $oaimme_hostname" >> /etc/hosts

update_config_file "oai-epc" "$oaimme_hostname" $OPENAIRCN_DIR/SRC/OAI_HSS/db/oai_db.sql >> $LOGFILE 2>&1
update_config_file "oai-epc" "$oaimme_hostname" $OPENAIRCN_DIR/SRC/OAI_HSS/db/pft_db.sql >> $LOGFILE 2>&1


