#!/bin/sh

read -p "Enter domain name [dockervpn.local]: " DOMAIN

if [ -z "$DOMAIN" ]
then
	DOMAIN="dockervpn.local"
fi

DOMAIN=$DOMAIN docker-compose build

./run.sh vpn -d

echo -e "dns\nvpn\n1194\n" | ./gen_client.sh
