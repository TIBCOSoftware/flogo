#!/bin/sh
# This script has at most 2 dependencies 
#       jq and curl   OR   jq and wget
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


checkDependencies() {
    if ! command_exists docker-compose ; then 
        cat >&2 <<-'EOF'
        Error: this installer needs "docker-compose"
        We are unable to find "docker-compose" to make this happen.
        EOF
        exit 1 
    fi
    if ! command_exists jq ; then 
        cat >&2 <<-'EOF'
        Error: this installer needs "jq"
        We are unable to find "jq" to make this happen.
        EOF
        exit 1 
    fi
    if command_exists curl ; then
       echo "Found curl ..."
    elif command_exists wget; then
        echo "Found wget ..."
    else 
        cat >&2 <<-'EOF'
        Error: this installer needs "curl" or "wget"
        We are unable to find either "curl" or "wget" available to make this happen.
        EOF
        exit 1 
    fi
}

getLatestRelease() {
    owner=${1:-"${GITHUB_OWNER}"}
    repo=${2:-"${GITHUB_REPO}"}
    github_url="https://api.github.com/repos/${owner}/${repo}/releases/latest"
    tag_name=$(curl -s ${github_url} | jq -r '.tag_name')
    if [ -n "${tag_name}" ]; then 
        cat >&2 <<-'EOF'
        Error: "Latest" release not found at https://github.com/TIBCOSoftware/flogo-web/releases
        EOF
    fi
    asset_urls=$(curl -s ${github_url} | jq -r '.assets[] | .browser_download_url' | grep "compose")
    for i in ${asset_urls}; do
    echo "Downloading ... ${i}"
    download_file ${i}
    done
}


download_file() {
    local file_url="${1}"
    if command_exists curl ; then
        curl -fsSLO ${file_url}
    elif command_exists wget; then
        wget --no-check-certificate -q -N -O ${file_url##*/}  ${file_url}
    fi
}

run_command() {
    checkDependencies
    getLatestRelease "TIBCOSoftware" "flogo"
    chmod +x ${script_root}/docker-compose-start.sh
    if command_exists docker-compose && [ -r ${script_root}/docker-compose.yml ] && [ -x ${script_root}/docker-compose-start.sh ]; then
        echo docker-compose -f ${script_root}/docker-compose.yml up
        echo docker-compose rm -f
    fi
}
# wrapped up in a function so that we have some protection against only getting
# half the file during "curl | sh"
run_command
