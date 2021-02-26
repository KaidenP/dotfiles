#!/bin/bash

#COLORS
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37
COLOR_NC='\033[0m'
COLOR_BLACK='\033[0;30m'
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_BROWN='\033[0;33m'
COLOR_BLUE='\033[0;34m'
COLOR_PURPLE='\033[0;35m'
COLOR_CYAN='\033[1;36m'

COLOR_LGREY='\033[0;37m'
COLOR_GRAY='\033[0;30m'
COLOR_LRED='\033[1;31m'
COLOR_LGREEN='\033[1;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_LBLUE='\033[1;34m'
COLOR_LPURPLE='\033[1;35m'
COLOR_LCYAN='\033[1;36m'
COLOR_WHITE='\033[1;37m'


log() {
	COLOR="${2:-$COLOR_LCYAN}"
	
	echo -e "${COLOR}${1}${COLOR_NC}"
}

log_warn() {
	log "$1" "$COLOR_LRED"
}

mkcd() {
	if [ $# -eq 0 ]; then
		echo "$0: <dir>"
		echo "Make and cd into dir."
		return 255
	fi
	mkdir $1
	cd $1
}