#!/bin/sh

BASEDIR="$(dirname $0)"
D_COMPOSE="docker-compose -f ${BASEDIR}/docker-compose.yml"
D_EXEC="${D_COMPOSE} run vpn"

read -p "Enter Client name: " CLIENT_NAME
read -s -p "Enter CA pass: " CA_PASS
echo

$D_EXEC sh -c "/vpn/scripts/revoke.sh ${CLIENT_NAME} ${CA_PASS}"
