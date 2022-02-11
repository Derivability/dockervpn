#!/bin/bash

function read_pass() {
	stty_orig=$(stty -g)
	stty -echo
	read -p "$1" password
	stty ${stty_orig}
	echo "${password}"
}
