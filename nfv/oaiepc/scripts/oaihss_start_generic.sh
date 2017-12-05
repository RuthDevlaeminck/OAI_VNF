#!/bin/bash
if [ -f "$SCRIPTS_PATH/func.sh" ]; then
        source $SCRIPTS_PATH/func.sh
else
        >&2 echo "$SERVICE: Could not find functions file $SCRIPTS_PATH/func.sh!"
        exit 1
fi

source_defaults_file

# start the hss
cd $OPENAIRCN_DIR/SCRIPTS
./hss_db_import $DB_HOST $HSS_USER $HSS_PASS $HSS_DB $HSS_DB_FILE
systemctl enable hss
systemctl start hss

