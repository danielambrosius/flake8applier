#!/usr/bin/env bash

URL=${1?Error: No url given}
BRANCH=${2:-main}

# appends .git if url is provided
if [[ $URL =~ \.git$ ]]
then
    echo "is a git repo"
else
    echo "appears to be url, appending .git"
    URL+=".git"
    echo "changed to: ${URL}"
fi

# clones repo into temp directory
git clone $URL -q -b $BRANCH ./tmp/
cd ./tmp

# gets a hold of files that have changed, and includes only the python files
DIRS=$(git diff --name-only --summary origin/master..origin/${BRANCH} | grep .py)
echo "following files included:"
echo $(echo $DIRS | sed -E "s/\s[a-z0-9\/\_]*\//, /g")
echo -e '\n\n'

#runs flake8 on those
flake8 $DIRS
cd ../
rm -Rf ./tmp