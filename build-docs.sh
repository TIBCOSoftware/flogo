#!/usr/bin/env bash

# Description: Build script for Project Flogo documentation
# Author: retgits <https://github.com/retgits>
# Last Updated: 2018-10-01

#--- Variables ---
HUGO_VERSION=0.74.3
HUGO_ARCH=64bit
#--- Download and install prerequisites ---
prerequisites() {
    if [ `uname -m` = 'aarch64' ]; then
            HUGO_ARCH=ARM64
            mkdir $HOME/gopath/bin
    fi
    wget -O hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-${HUGO_ARCH}.tar.gz
    mkdir -p hugobin
    tar -xzvf hugo.tar.gz -C ./hugobin
    mv ./hugobin/hugo $HOME/gopath/bin
    rm hugo.tar.gz && rm -rf ./hugobin
}

#--- Get external docs ---
ext_docs() {
    echo "Getting the docs for the activities and triggers"
    git clone https://github.com/project-flogo/contrib
    for i in `find contrib/activity -name \*.md` ; do filename=$(basename $(dirname $i)); cp $i docs/content/development/webui/activities/$filename.md; sed -i -e 's/<!--/---/g' -e 's/-->/---/g' docs/content/development/webui/activities/$filename.md; done;
    for i in `find contrib/trigger -name \*.md` ; do filename=$(basename $(dirname $i)); cp $i docs/content/development/webui/triggers/$filename.md; sed -i -e 's/<!--/---/g' -e 's/-->/---/g' docs/content/development/webui/triggers/$filename.md; done;
    for i in `find contrib/function -name \*.md` ; do filename=$(basename $(dirname $i)); cp $i docs/content/development/webui/functions/$filename.md; sed -i -e 's/<!--/---/g' -e 's/-->/---/g' docs/content/development/webui/functions/$filename.md; done;
    rm -rf flogo-contrib

    echo "Getting the docs for the commandline tools"
    curl -o docs/content/flogo-cli/flogo-cli.md https://raw.githubusercontent.com/project-flogo/cli/master/docs/commands.md
    sed -i -e 's/<!--/---/g' -e 's/-->/---/g' docs/content/flogo-cli/flogo-cli.md
    curl -o docs/content/flogo-cli/plugins.md https://raw.githubusercontent.com/project-flogo/cli/master/docs/plugins.md
    sed -i -e 's/<!--/---/g' -e 's/-->/---/g' docs/content/flogo-cli/plugins.md
    curl -o docs/content/flogo-cli/dev-plugin.md https://raw.githubusercontent.com/project-flogo/cli-plugins/master/devtool/README.md
    sed -i -e 's/<!--/---/g' -e 's/-->/---/g' docs/content/flogo-cli/dev-plugin.md
}

#--- Update contributions page ---
update_page_contrib() {
    echo "Update contributing page"
    cp CONTRIBUTING.md docs/content/contributing/contributing.md
    sed -i '1d' docs/content/contributing/contributing.md
    sed -i '1i ---' docs/content/contributing/contributing.md
    sed -i '1i weight: 9010' docs/content/contributing/contributing.md
    sed -i '1i title: Contributing to Project Flogo' docs/content/contributing/contributing.md
    sed -i '1i ---' docs/content/contributing/contributing.md
}

#--- Update introduction page ---
update_page_introduction() {
    cp README.md docs/content/introduction/_index.md
    sed -i '1,4d' docs/content/introduction/_index.md
    sed -i '5,17d' docs/content/introduction/_index.md
    sed -i '1i ---' docs/content/introduction/_index.md
    sed -i '1i pre: "<i class=\\"fas fa-home\\" aria-hidden=\\"true\\"></i> "' docs/content/introduction/_index.md
    sed -i '1i weight: 1000' docs/content/introduction/_index.md
    sed -i '1i title: Introduction' docs/content/introduction/_index.md
    sed -i '1i ---' docs/content/introduction/_index.md
    sed -i 's#images/eventhandlers.png#https://raw.githubusercontent.com/TIBCOSoftware/flogo/master/images/eventhandlers.png#g' docs/content/introduction/_index.md
    sed -i 's#images/flogostack.png#https://raw.githubusercontent.com/TIBCOSoftware/flogo/master/images/flogostack.png#g' docs/content/introduction/_index.md
    sed -i 's#images/flogo-web2.gif#https://raw.githubusercontent.com/TIBCOSoftware/flogo/master/images/flogo-web2.gif#g' docs/content/introduction/_index.md
    sed -i 's#images/flogo-cli.gif#https://raw.githubusercontent.com/TIBCOSoftware/flogo/master/images/flogo-cli.gif#g' docs/content/introduction/_index.md
}

#--- Update page ---
update_page() {
    case "$1" in
        "contributing")
            update_page_contrib
            ;;
        "introduction")
            update_page_introduction
            ;;
        *)
            echo "Updating all pages"
            update_page_contrib
            update_page_introduction
    esac
}

#--- Execute build ---
build() {
    echo "Build docs site..."
    cd docs && hugo
    cd ../showcases && hugo
    mv public ../docs/public/showcases
    cd ../docs
    cd public && ls -alh
}


case "$1" in 
    "prerequisites")
        prerequisites
        ;;
    "ext-docs")
        ext_docs
        ;;
    "update-page")
        update_page $2
        ;;
    "build")
        build
        ;;
    *)
        echo "The target {$1} you want to execute doesn't exist"
esac
