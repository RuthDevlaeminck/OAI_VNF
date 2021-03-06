#!/bin/bash

if [ -f "$SCRIPTS_PATH/func.sh" ]; then
        source $SCRIPTS_PATH/func.sh
else
        >&2 echo "$SERVICE: Could not find functions file $SCRIPTS_PATH/func.sh!"
        exit 1
fi

source_defaults_file

# and since we don't want to have to enter the gui for phpmyadmin
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_PASSWORD'"
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $HSS_PASS" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $DB_PASSWORD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $HSS_PASS" | debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections
apt install phpmyadmin -y


cp $OPENAIRCN_ETC/hss.conf $ETC_TARGET
cp $OPENAIRCN_ETC/acl.conf $ETC_TARGET/freeDiameter
cp $OPENAIRCN_ETC/hss_fd.conf $ETC_TARGET/freeDiameter


update_config_file "MYSQL_user   = \"@MYSQL_user@\";" "MYSQL_user   = \"$HSS_USER\";" $ETC_TARGET/hss.conf
update_config_file "MYSQL_pass   = \"@MYSQL_pass@\";" "MYSQL_pass   = \"$HSS_PASS\";" $ETC_TARGET/hss.conf
update_config_file "OPERATOR_key = \"1006020f0a478bf6b699f15c062e42b3\"" "OPERATOR_key = \"$OPERATOR_KEY\""  $ETC_TARGET/hss.conf

cd $OPENAIRCN_SCRIPTS
./check_hss_s6a_certificate $ETC_TARGET/freeDiameter hss.openair4G.eur

mysql -u root -p$DB_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO '$HSS_USER'@'localhost' IDENTIFIED BY '$HSS_PASS' WITH GRANT OPTION;" 
mysql -u root -p$DB_PASSWORD -e "FLUSH PRIVILEGES;"

install_service_file "hss"
