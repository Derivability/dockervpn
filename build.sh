#!/bin/sh

BASEDIR=$(dirname $0)
D_COMPOSE="docker-compose -f ${BASEDIR}/docker-compose.yml"

read -p "Enter domain name [dockervpn.local]: " DOMAIN
read -s -p "Enter new CA password: " CA_PASS
echo

if [ -z "$DOMAIN" ]
then
	export DOMAIN="dockervpn.local"
else
	export DOMAIN="${DOMAIN}"
fi

$D_COMPOSE build

$D_COMPOSE run vpn scripts/pkigen.sh $CA_PASS

echo -e "dns\nvpn\n1194\n${CA_PASS}" | ${BASEDIR}/gen_client.sh

$D_COMPOSE down
