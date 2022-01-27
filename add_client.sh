#!/bin/sh
set -e

ersa=/usr/share/easy-rsa/easyrsa

echo "" | $ersa gen-req $1 nopass
echo -e "yes\n" | $ersa sign-req client $1

