#!/bin/bash

set -euo pipefail

declare SITE=${1:-site.yml}
declare REPO=${2:-$(git remote get-url origin)}
declare BRANCH="gh-pages"
declare _CURR_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
# NOTE: WORKSPACE_ROOT defined from devcontainer.json if running from within vscode
declare REPO_ROOT=${WORKSPACE_ROOT:-${_CURR_DIR}}

echo "Removing old publish directory"
if [[ -d $REPO_ROOT/gh-pages ]]; then
    rm -rf $REPO_ROOT/gh-pages 
fi

echo "Removing antora cache directory"
if [[ -d $REPO_ROOT/.cache ]]; then
    rm -rf $REPO_ROOT/.cache 
fi

git clone -b ${BRANCH} ${REPO} $REPO_ROOT/gh-pages

echo "Generating the site documentation from ${SITE}"

antora generate --stacktrace $REPO_ROOT/${SITE} --to-dir $REPO_ROOT/gh-pages

echo "Pushing site to ${BRANCH} branch of ${REPO}"
cd $REPO_ROOT/gh-pages
git add --all .
git commit -m"Automated Publish" 
git push origin

echo "Site published successfully!"