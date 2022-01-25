#!/bin/sh

read -s -p "Enter root CA password: " CA_PASS
echo

docker build -t "dockervpn:latest" --build-arg CA_PASS=${CA_PASS} .
