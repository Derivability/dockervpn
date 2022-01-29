#!/bin/sh

if [ ! -f "pki/ca.crt" ]
then
	echo "yes" | scripts/pkigen.sh
fi

#exec openvpn server.conf
