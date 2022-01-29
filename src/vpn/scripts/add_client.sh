#!/bin/sh
set -e

CA_PASS=$2

function ERSA()
{
	/usr/share/easy-rsa/easyrsa --passin=file:<(echo ${CA_PASS}) --passout=file:<(echo ${CA_PASS}) $@
}

echo "" | ERSA gen-req $1 nopass
echo -e "yes\n" | ERSA sign-req client $1

