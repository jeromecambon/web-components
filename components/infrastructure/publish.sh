#!/bin/bash

usage() {
  command=$(basename $0)
  echo ""
  echo -e "SYNOPSIS"
  echo -e "    $command --component=<component>"
  echo ""
  echo -e "DESCRIPTION"
  echo "  Publish the specified component to npm registry"
  echo ""
  echo -e "ARGUMENTS"
  echo -e "  --component=component      component to publish"
  echo ""
  echo -e "  --help                   display this help"
  echo ""
  exit 1;
}

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
BASE_DIR=$SCRIPT_DIR/..

for i in "$@"; do
    case $i in
        --component=*)
        COMPONENT="${i#*=}"
        shift
        ;;
         --help)
        usage
        ;;
    esac
done

if [ -z "$COMPONENT" ]; then
  echo "ERROR: --component is required";
  usage;
fi

cd "$BASE_DIR/packages/$COMPONENT" || exit

## Push on npm repository
# Check if user is logged on npm registry
NPM_USER=$(npm whoami)

if [ "$NPM_USER" ]; then
    npm publish --access public
    echo "Publish ${COMPONENT} on npm registry as  ${NPM_USER}"
fi