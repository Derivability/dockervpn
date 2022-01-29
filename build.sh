#!/bin/sh

read -p "Enter domain name [dockervpn.local]: " DOMAIN

if [ -z "$DOMAIN" ]
then
	export DOMAIN="dockervpn.local"
fi

DOMAIN=$DOMAIN docker-compose build

./run.sh vpn -d

sleep 5
echo -e "dns\nvpn\n1194\n" | ./gen_client.sh

docker-compose stop vpn
