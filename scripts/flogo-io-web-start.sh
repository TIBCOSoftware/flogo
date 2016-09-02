#!/bin/sh
set -x
#
# This script is meant for quick & easy install via:
#   'curl -sSL https://github.com/TIBCOSoftware/flogo-web/releases/download/${GITHUB_TAG}/start-flogo-web.txt | sh'
# or:
#   'wget -qO- https://github.com/TIBCOSoftware/flogo-web/releases/download/${GITHUB_TAG}/start-flogo-web.txt | sh'
#

script_root=$(dirname "${BASH_SOURCE}")
command_exists() {
       	command -v "$@" > /dev/null 2>&1
}
export DOCKER_REGISTRY=localhost:5000/
export BUILD_RELEASE_TAG=latest
export GITHUB_TAG=##GITHUB_TAG##
compose_url="https://github.com/TIBCOSoftware/flogo-web/releases/download/${GITHUB_TAG}/docker-compose.yml"

download_compose_file() {
   
    if [ ! -f ${script_root}/docker-compose.yml ]; then 
         if command_exists curl ; then
            curl -sSO ${compose_url}
        elif command_exists wget; then
            wget -qO- --no-check-certificate ${compose_url}
        fi
    else 
        echo "Found docker-compose.yml"
    fi
}

run_command() {
    download_compose_file
    if command_exists docker-compose && [ -f ${script_root}/docker-compose.yml ]; then
        docker-compose -f ${script_root}/docker-compose.yml up
        docker-compose rm -f
    fi
}
run_command
