#!/bin/bash

if [ -f "$SCRIPTS_PATH/func.sh" ]; then
        source $SCRIPTS_PATH/func.sh
else
        >&2 echo "$SERVICE: Could not find functions file $SCRIPTS_PATH/func.sh!"
        exit 1
fi

source_defaults_file

echo "$oaimme_mgmt_oa       $oaimme_hostname.openair-cn.openair4G.eur   $oaimme_hostname" >> /etc/hosts

update_config_file "yang" "$oaimme_hostname" $HSS_DB_FILE >> $LOGFILE 2>&1
update_config_file "yang" "$oaimme_hostname" $OPENAIRCN_HSS_DB_DIR/pft_db.sql >> $LOGFILE 2>&1


