#!/bin/sh

BASEDIR=$(dirname $0)

if [ ! -f "${BASEDIR}/pki/ca.crt" ]
then
	read -s -p "Enter CA password: " CA_PASS
	echo
	echo "${CA_PASS}" > "${BASEDIR}/pki/ca_pass"
fi

docker-compose up $@
