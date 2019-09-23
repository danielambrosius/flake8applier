#!/usr/bin/env bash

URL=${1?Error: No url given}
BRANCH=${2:-main}

if [[ $URL =~ \.git$ ]]
then
    echo "is a git repo"
else
    echo "appears to be url, appending .git"
    URL+=".git"
    echo "changed to: ${URL}"
fi

git clone $URL -q -b $BRANCH ./tmp/
cd ./tmp
DIRS=$(git diff --name-only --summary origin/master..origin/${BRANCH} | grep .py)
echo "following files included:"
echo $(echo $DIRS | sed -E "s/\s[a-z0-9\/\_]*\//, /g")
echo -e '\n\n'
flake8 $DIRS
cd ../
rm -Rf ./tmp