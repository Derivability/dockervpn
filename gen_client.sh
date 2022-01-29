#!/bin/sh

read -p "Enter Client name: " CLIENT_NAME
read -p "Enter server IP address: " IP_ADDR
read -p "Enter server port: " PORT

export CA_PASS=""
export DOMAIN=""
BASEDIR=$(dirname $0)
D_COMPOSE="docker-compose -f ${BASEDIR}/docker-compose.yml"
D_EXEC="${D_COMPOSE}  exec vpn"

if [ -z "$(${D_COMPOSE} ps | grep vpn | grep running)" ]
then
	MANUAL_START=1
else
	MANUAL_START=0
fi

if [ "$MANUAL_START" -eq 1 ]
then
	${BASEDIR}/run.sh vpn -d
fi

$D_EXEC test -f /vpn/pki/issued/${CLIENT_NAME}.crt
if [ "$?" != 0 ]
then
	set -e
	$D_EXEC /vpn/scripts/add_client.sh ${CLIENT_NAME} ${CA_PASS}
fi

CONF_FILE="${BASEDIR}/clients/${CLIENT_NAME}.ovpn"
D_CONF_FILE="/vpn/clients/${CLIENT_NAME}.ovpn"
rm -rf ${CONF_FILE}
cp ${BASEDIR}/src/vpn/conf_templates/client.conf ${CONF_FILE}
sed -i "s/__IP_ADDRESS__/${IP_ADDR}/" ${CONF_FILE}
sed -i "s/__PORT__/${PORT}/" ${CONF_FILE}

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
$D_EXEC sh -c "cat /vpn/pki/ta.key >> ${D_CONF_FILE};"
echo "</tls-crypt>" >> ${CONF_FILE}

echo "Done!"

if [ "$MANUAL_START" -eq 1 ]
then
	${D_COMPOSE} stop vpn
fi
