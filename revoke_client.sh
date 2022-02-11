#!/bin/sh

BASEDIR="$(dirname $0)"
source ${BASEDIR}/lib/utils.sh

D_COMPOSE="docker-compose -f ${BASEDIR}/docker-compose.yml"
D_EXEC="${D_COMPOSE} run vpn"

read -p "Enter Client name: " CLIENT_NAME
CA_PASS=$(read_pass "Enter CA pass: ")
echo

$D_EXEC sh -c "/vpn/scripts/revoke.sh ${CLIENT_NAME} ${CA_PASS}"
