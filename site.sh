#!/bin/bash

declare SITE_YAML=${1:-site.yml}

_CURR_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
rm -rf $_CURR_DIR/gh-pages $_CURR_DIR/.cache

antora --pull --stacktrace ${SITE_YAML}