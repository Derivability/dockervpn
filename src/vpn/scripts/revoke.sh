#!/bin/sh

CLIENT_NAME=$1
CA_PASS=$2

function ERSA()
{
	/usr/share/easy-rsa/easyrsa --passin=file:<(echo ${CA_PASS}) --passout=file:<(echo ${CA_PASS}) $@
}

echo "Revoking certificate of \"${CLIENT_NAME}\""

echo yes | ERSA revoke ${CLIENT_NAME}

ERSA gen-crl
