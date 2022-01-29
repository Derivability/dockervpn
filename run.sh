#!/bin/sh

BASEDIR=$(dirname $0)

if [ -z "${DOMAIN}" ]
then
	export DOMAIN=""
fi

docker-compose up $@
