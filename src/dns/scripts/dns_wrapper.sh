#!/bin/sh

DOMAIN="$(cat /etc/dnsmasq.conf | grep 'local=' | cut -f 2 -d '/')"
HOST_FILE=/etc/hosts.openvpn
STATUS_FILE=/shared/openvpn-status.log
VPN_FILE=/shared/clients/dns.ovpn
dnsmasq -d &
openvpn ${VPN_FILE} &
DPID="$(pgrep dnsmasq)"
VPID="$(pgrep openvpn)"

function log()
{
	echo "$(date +'%Y-%m-%d %H:%M:%S') $1"
}

function trap_term()
{
	kill ${DPID}
	kill ${VPID}
	log "Caught SIGTERM. Exiting"
	exit 0
}

trap "trap_term" TERM

touch ${HOST_FILE}

CLIENTS=""
while true
do
	sleep 10

	NEW_CLIENTS="$(grep -E '^(\d{1,3}\.){3}\d{1,3}\,.*\,(\d{1,3}\.){3}\d{1,3}:' ${STATUS_FILE})"

	if [ "${NEW_CLIENTS}" == "${CLIENTS}" ] || [ -z "${NEW_CLIENTS}" ]
	then
		continue
	fi

	CLIENTS="${NEW_CLIENTS}"

	echo > ${HOST_FILE}
	echo "${CLIENTS}" | while IFS= read -r CLIENT
	do
		IP="$(echo ${CLIENT} | cut -f 1 -d ',')"
		NAME="$(echo ${CLIENT} | cut -f 2 -d ',')"
		echo "${IP} ${NAME} ${NAME}.${DOMAIN}" >> ${HOST_FILE}
	done
	kill -1 ${DPID}
done
