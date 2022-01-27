#!/bin/sh

read -p "Enter Client name: " CLIENT_NAME
read -p "Enter server IP address: " IP_ADDR

export CA_PASS=""
BASEDIR=$(dirname $0)
D_EXEC="docker-compose -f ${BASEDIR}/docker-compose.yml exec dockervpn"

$D_EXEC test -f /vpn/pki/issued/${CLIENT_NAME}.crt
if [ "$?" != 0 ]
then
	set -e
	$D_EXEC /vpn/scripts/add_client.sh ${CLIENT_NAME} ${CA_PASS}
fi


CONF_FILE="${BASEDIR}/clients/${CLIENT_NAME}.ovpn"
D_CONF_FILE="/vpn/clients/${CLIENT_NAME}.ovpn"
rm -rf ${CONF_FILE}
cp ${BASEDIR}/src/conf_templates/client.conf ${CONF_FILE}
sed -i "s/__IP_ADDRESS__/${IP_ADDR}/" ${CONF_FILE}

echo "<ca>" >> ${CONF_FILE}
$D_EXEC sh -c "cat /vpn/pki/ca.crt >> ${D_CONF_FILE}"
echo "</ca>">> ${CONF_FILE}
echo "<cert>" >> ${CONF_FILE}
$D_EXEC sh -c "cat /vpn/pki/issued/${CLIENT_NAME}.crt >> ${D_CONF_FILE}"
echo "</cert>" >> ${CONF_FILE}
echo "<key>" >> ${CONF_FILE}
$D_EXEC sh -c "cat /vpn/pki/private/${CLIENT_NAME}.key >> ${D_CONF_FILE}"
echo "</key>" >> ${CONF_FILE}
echo "<tls-crypt>" >> ${CONF_FILE}
$D_EXEC sh -c "cat /vpn/ta.key >> ${D_CONF_FILE};"
echo "</tls-crypt>" >> ${CONF_FILE}

echo "Done!"
