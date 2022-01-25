#!/bin/sh
set -e

ersa=/usr/share/easy-rsa/easyrsa

$ersa gen-req $1
$ersa sign-req client $1
