#!/bin/sh

read -s -p "Enter root CA password: " CA_PASS
echo

CA_PASS=${CA_PASS} docker-compose build
