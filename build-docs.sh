#!/bin/bash

echo "Prepare docs..."
echo "Update contributing page"
cp CONTRIBUTING.md docs/content/contributing/contributing.md
sed -i '1d' docs/content/contributing/contributing.md
sed -i '1i ---' docs/content/contributing/contributing.md
sed -i '1i weight: 9010' docs/content/contributing/contributing.md
sed -i '1i title: Contributing to Project Flogo' docs/content/contributing/contributing.md
sed -i '1i ---' docs/content/contributing/contributing.md

echo "Getting the docs for the activities and triggers"
git clone https://github.com/TIBCOSoftware/flogo-contrib
for i in `find flogo-contrib/activity -name \*.md` ; do filename=$(basename $(dirname $i)); cp $i docs/content/development/webui/activities/$filename.md; done;
for i in `find flogo-contrib/trigger -name \*.md` ; do filename=$(basename $(dirname $i)); cp $i docs/content/development/webui/triggers/$filename.md; done;
rm -rf flogo-contrib

echo "Build docs site..."
cd docs && hugo
cd ../showcases && hugo
mv public ../docs/public/showcases
cd ../docs
cd public && ls -alh