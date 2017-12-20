#!/bin/bash

function update_config_file {
    data_in=$1
    data_out=$2
    file=$3

    # Overwrite the supplied variable in OpenEPC's config files
    if [ -f $file ]; then
        sed -i -e "s/$data_in/$data_out/g" $file
        echo "$SERVICE: Changed config file $file from ${data_in} to ${data_out}"
    else
        >&2 echo "$SERVICE: Could not find config file $file!"
            exit 1
    fi
}

function source_generic_service_file {
    service=$1
    lifecycle_event=$2
    args="${@:3}"
    file="$SCRIPTS_PATH/${service}_${lifecycle_event}_generic.sh"

    if [ -f $file ]; then
        source $file $args
        echo "$SERVICE: Sourced generic $lifecycle_event file for $service"
    else
        >&2 echo "$SERVICE: Could not find generic service file $file!"
            exit 1
    fi
}

function source_defaults_file {
   if [ -f "$SCRIPTS_PATH/default_vals_general" ]; then
            source $SCRIPTS_PATH/default_vals_general
   else
           >&2 echo "$SERVICE: Could not find defaults file $SCRIPTS_PATH/default_vals_general!"
   fi
   if [ -f "$SCRIPTS_PATH/default_vals" ]; then
            source $SCRIPTS_PATH/default_vals
   else
           >&2 echo "$SERVICE: Could not find defaults file $SCRIPTS_PATH/default_vals!"
   fi
}

function create_interface_config_file {
    interface=$1

    interfaces_file=$INTERFACES_DIR/$interface.cfg
    echo "interfaces file is $interfaces_file"
    if [ -f "$interfaces_file" ]; then
        echo "$SERVICE: replacing interface file $interfaces_file"
        rm $interfaces_file
    fi

    echo "auto $interface" >> $interfaces_file
    echo "iface $interface inet dhcp" >> $interfaces_file
    ifup $interface
}


function install_openvpn {
  apt install -y screen openvpn
  apt-get update
  mkdir -p ~/openvpn-ca/keys
  mkdir -p ~/client-configs/files/
  chmod 700 ~/client-configs/files
}

function getInterfaceName {
  interfaceNumber=$1
  name=$(ifconfig -a | grep HWaddr | head -$interfaceNumber | tail -1 | cut -d' ' -f1)
  echo $name
}



function install_service_file()
{
  SERVICE_INSTALL=$1
  SERVICE_TEMPLATE=$SCRIPTS_PATH/oai.service
  SERVICE_DIR=/etc/systemd/system
  SERVICE_FILE=$SERVICE_DIR/$SERVICE_INSTALL.service
  RUN_FILE=$SCRIPTS_PATH/run_oai.sh

  sed -i -e "s:%OPENAIRCN_SCRIPTS%:$OPENAIRCN_SCRIPTS:g" $RUN_FILE
  cp $RUN_FILE $OPENAIRCN_SCRIPTS
  cp $SERVICE_TEMPLATE $SERVICE_FILE
  sed -i -e "s:%OPENAIRCN_SCRIPTS%:$OPENAIRCN_SCRIPTS:g" $SERVICE_FILE
  sed -i -e "s:%SERVICE%:$SERVICE_INSTALL:g" $SERVICE_FILE
}


