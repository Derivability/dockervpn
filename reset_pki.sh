#!/bin/sh

BASEDIR="$(dirname $0)"
D_COMPOSE="docker-compose -f ${BASEDIR}/docker-compose.yml"
D_EXEC="${D_COMPOSE} exec vpn sh -c "

if [ -z "$(${D_COMPOSE} ps | grep vpn | grep 'running\|Up')" ]
then
	MANUAL_START=1
else
	MANUAL_START=0
fi

if [ "$MANUAL_START" -eq 1 ]
then
	${BASEDIR}/run.sh vpn -d
fi

$D_EXEC 'rm -r /vpn/pki/*'

if [ "$MANUAL_START" -eq 1 ]
then
	${D_COMPOSE} stop vpn
fi
