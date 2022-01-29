#!/bin/sh
set -e

CA_PASS=$1
PKI_DIR=/vpn/pki
cd /vpn

function ERSA()
{
	/usr/share/easy-rsa/easyrsa --passin=file:<(echo ${CA_PASS}) --passout=file:<(echo ${CA_PASS}) $@
}

rm -rf ${PKI_DIR}/ca_pass

echo "yes" | ERSA init-pki
echo "DockerVPN CA" | ERSA build-ca

echo | ERSA gen-req dockervpn nopass
echo "yes" | ERSA sign-req server dockervpn
ERSA gen-crl

openssl dhparam -dsaparam -out ${PKI_DIR}/dh.pem 4096

openvpn --genkey tls-crypt ${PKI_DIR}/ta.key
