#!/bin/sh

BASEDIR=$(dirname $0)

read -p "Enter domain name [dockervpn.local]: " DOMAIN

if [ -z "$DOMAIN" ]
then
	export DOMAIN="dockervpn.local"
else
	export DOMAIN="${DOMAIN}"
fi

docker-compose build

${BASEDIR}/run.sh vpn -d

echo -n "Initializing Public Key Infrastructure"
while [ ! -f "${BASEDIR}/pki/ta.key" ]
do
	echo -n "."
	sleep 1
done
echo

echo -e "dns\nvpn\n1194\n" | ${BASEDIR}/gen_client.sh
docker-compose stop vpn
