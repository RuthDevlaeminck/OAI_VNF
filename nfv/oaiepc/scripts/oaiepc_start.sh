if [ -f "$SCRIPTS_PATH/func.sh" ]; then
        source $SCRIPTS_PATH/func.sh
else
        >&2 echo "$SERVICE: Could not find functions file $SCRIPTS_PATH/func.sh!"
        exit 1
fi

source_defaults_file
source_generic_service_file "oaihss" "start"
source_generic_service_file "oaimme" "start"
source_generic_service_file "oaispgw" "start"

