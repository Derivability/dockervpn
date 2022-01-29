#!/bin/sh
set -e

ersa=/usr/share/easy-rsa/easyrsa
PKI_DIR=/vpn/pki
cd /vpn

CA_PASS=$(cat pki/ca_pass)
rm -rf ${PKI_DIR}/ca_pass

$ersa init-pki
echo -e "${CA_PASS}\n${CA_PASS}\n" | $ersa build-ca

echo | $ersa gen-req dockervpn nopass
echo -e "yes\n${CA_PASS}" | $ersa sign-req server dockervpn

openssl dhparam -dsaparam -out ${PKI_DIR}/dh.pem 4096

openvpn --genkey tls-crypt ${PKI_DIR}/ta.key
