#!/bin/bash

echo "Prepare docs..."
echo "Update contributing page"
cp CONTRIBUTING.md docs/content/contributing/contributing.md
sed -i '1d' docs/content/contributing/contributing.md
sed -i '1i ---' docs/content/contributing/contributing.md
sed -i '1i weight: 9010' docs/content/contributing/contributing.md
sed -i '1i title: Contributing to Project Flogo' docs/content/contributing/contributing.md
sed -i '1i ---' docs/content/contributing/contributing.md

echo "Updating the frontpage"
cp README.md docs/content/introduction/_index.md
sed -i '9,20d' docs/content/introduction/_index.md
sed -i '1i ---' docs/content/introduction/_index.md
sed -i '1i pre: "<i class=\\"fa fa-home\\" aria-hidden=\\"true\\"></i> "' docs/content/introduction/_index.md
sed -i '1i weight: 1000' docs/content/introduction/_index.md
sed -i '1i title: Introduction' docs/content/introduction/_index.md
sed -i '1i ---' docs/content/introduction/_index.md

echo "Getting the docs for the activities and triggers"
git clone https://github.com/TIBCOSoftware/flogo-contrib
for i in `find flogo-contrib/activity -name \*.md` ; do filename=$(basename $(dirname $i)); cp $i docs/content/development/webui/activities/$filename.md; done;
for i in `find flogo-contrib/trigger -name \*.md` ; do filename=$(basename $(dirname $i)); cp $i docs/content/development/webui/triggers/$filename.md; done;
rm -rf flogo-contrib

echo "Getting the docs for the commandline tools"
curl -o docs/content/flogo-cli/flogo-cli.md https://raw.githubusercontent.com/TIBCOSoftware/flogo-cli/master/docs/flogo-cli.md
curl -o docs/content/flogo-cli/flogodevice-cli.md https://raw.githubusercontent.com/TIBCOSoftware/flogo-cli/master/docs/flogodevice-cli.md
curl -o docs/content/flogo-cli/flogogen-cli.md https://raw.githubusercontent.com/TIBCOSoftware/flogo-cli/master/docs/flogogen-cli.md
curl -o docs/content/flogo-cli/tools-overview.md https://raw.githubusercontent.com/TIBCOSoftware/flogo-cli/master/docs/tools-overview.md

echo "Build docs site..."
cd docs && hugo
cd ../showcases && hugo
mv public ../docs/public/showcases
cd ../docs
cd public && ls -alh
