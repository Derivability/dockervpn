#!/bin/sh

BASEDIR="$(dirname $0)"
D_EXEC="docker-compose -f ${BASEDIR}/docker-compose.yml exec dockervpn sh -c "

$D_EXEC 'rm -r /vpn/pki/*'
