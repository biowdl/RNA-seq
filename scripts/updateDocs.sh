#!/usr/bin/env bash
set -eu

GIT_ROOT="$(git rev-parse --show-toplevel)"
cd $GIT_ROOT

# Determine the version
TAG=`git tag -l --points-at HEAD`
if [ "${TAG}" == '' ]
  then
    BRANCH=`git rev-parse --abbrev-ref HEAD`
    if [ "${BRANCH}" == 'develop' ]
      then
        VERSION='develop'
      else
        echo 'You are currently not on a tagged commit or develop!'
        exit 1
    fi
  else
    VERSION="${TAG}"
fi
echo "Updating documention for version ${VERSION}"

# Checkout gh-pages and pull the docs over from the original branch
git checkout gh-pages
git pull
git checkout $VERSION -- docs

# Rename the docs to the version
if [ -d "${VERSION}" ]
  then
    rm -r $VERSION
fi
mv docs $VERSION

# Adjust the config if necessary
echo "set version '${VERSION}' to latest?"
select yn in "Yes" "No"
  do
    case $yn in
        Yes ) sed -i "s/latest: .*/latest: ${VERSION}/" _config.yml; break;;
        No ) break;;
    esac
done
grep 'latest:' < _config.yml

# commit and push
echo "committing and pushing"
git add ${VERSION}/* _config.yml docs/*
git commit -m "update documention for version ${VERSION}"
git push origin gh-pages

# switch back to version
git checkout $VERSION

echo "DONE"
