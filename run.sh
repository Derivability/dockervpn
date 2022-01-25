#!/bin/sh

docker run -d --cap-add=NET_ADMIN --device /dev/net/tun -p 1194:1194/udp --rm -it --name dockervpn_server dockervpn
