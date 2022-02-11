#!/bin/bash

BASEDIR=$(dirname $0)
source ${BASEDIR}/lib/utils.sh
D_COMPOSE="docker-compose -f ${BASEDIR}/docker-compose.yml"

read -p "Enter domain name [dockervpn.local]: " DOMAIN

if [ ! -f "${BASEDIR}/pki/ca.crt" ]
then
	CA_PASS=$(read_pass "Enter new CA password: ")
fi

if [ -z "$DOMAIN" ]
then
	export DOMAIN="dockervpn.local"
else
	export DOMAIN="${DOMAIN}"
fi

$D_COMPOSE build

if [ ! -f "${BASEDIR}/pki/ca.crt" ]
then
	$D_COMPOSE run vpn scripts/pkigen.sh $CA_PASS

	echo -e "dns\nvpn\n1194\n${CA_PASS}" | ${BASEDIR}/gen_client.sh

	$D_COMPOSE down
fi
