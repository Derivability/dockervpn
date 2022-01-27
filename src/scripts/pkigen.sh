#!/bin/sh
set -e

ersa=/usr/share/easy-rsa/easyrsa

$ersa init-pki
echo -e "${CA_PASS}\n${CA_PASS}\n" | $ersa build-ca

echo | $ersa gen-req dockervpn nopass
echo -e "yes\n${CA_PASS}" | $ersa sign-req server dockervpn

openssl dhparam -dsaparam -out dh.pem 4096

openvpn --genkey tls-crypt ta.key
