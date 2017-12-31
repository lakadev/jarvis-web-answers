#!/bin/bash
# This file will be automatically sourced at the installation of your plugin
# Use only if you need to perform changes on the user system such as installing software
jv_debug "Downloading pup parser"
jv_pg_wa_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/
if [[ "$platform" == "linux" ]]; then
	# Start in new terminal to avoid blocking Jarvis              
	wget "https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_arm.zip"
	unzip -j "pup_v0.4.0_linux_arm.zip" "pup" -d $jv_pg_wa_root
	rm pup_v0.4.0_linux_arm.zip
elif [[ "$platform" == "osx" ]]; then
    wget "https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_darwin_amd64.zip"
    unzip -j "pup_v0.4.0_darwin_amd64.zip" "pup" -d $jv_pg_wa_root
	rm pup_v0.4.0_darwin_amd64.zip
fi
