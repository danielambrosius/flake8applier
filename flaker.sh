#!/usr/bin/env bash

URL=${1?Error: No url given}
BRANCH=${2:-main}
rm -Rf ./tmp

if [[ $URL =~ \.git$ ]]
then
    echo "is a git repo"
else
    echo "appears to be url, appending .git"
    URL+=".git"
    echo "changed to: ${URL}"
fi

git clone $URL -b $BRANCH ./tmp/
cd ./tmp
git diff --summary origin/master..origin/${BRANCH} | grep .py
echo $DIRS
cd ../
pwd