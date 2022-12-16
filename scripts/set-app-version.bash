#!/usr/bin/env bash

set -e # exit on error
#set -x # print commands

# Usage: bash scripts/set-app-version.bash x.y.x

NEW_APP_VERSION=$1
if [ -z "$NEW_APP_VERSION" ]; then
  echo "Usage: bash scripts/set-app-version.bash x.y.z"
  exit 1
fi

# read app version from pubspec.yaml
CURRENT_FULL_APP_VERSION=$(sed -n 's/^version: //p' pubspec.yaml)
CURRENT_APP_VERSION=$(echo $CURRENT_FULL_APP_VERSION | cut -d'+' -f1)
CURRENT_BUILD_NUMBER=$(echo $CURRENT_FULL_APP_VERSION | cut -d'+' -f2)

NEW_BUILD_NUMBER=$((CURRENT_BUILD_NUMBER + 1))
NEW_FULL_APP_VERSION="$NEW_APP_VERSION+$NEW_BUILD_NUMBER"

CURRENT_MSIX_VERSION="$CURRENT_APP_VERSION.0"
NEW_MSIX_VERSION="$NEW_APP_VERSION.0"

CURRENT_WINDOWS_VERSION_AS_NUMBER=$(echo $CURRENT_APP_VERSION | tr '.' ',')
NEW_WINDOWS_VERSION_AS_NUMBER=$(echo $NEW_APP_VERSION | tr '.' ',')

CURRENT_WINDOWS_VERSION_AS_STRING=$CURRENT_APP_VERSION
NEW_WINDOWS_VERSION_AS_STRING=$NEW_APP_VERSION

# set new version
sed -i "" "s/^version: $CURRENT_FULL_APP_VERSION/version: $NEW_FULL_APP_VERSION/" pubspec.yaml
sed -i "" "s/^  msix_version: $CURRENT_MSIX_VERSION/  msix_version: $NEW_MSIX_VERSION/" pubspec.yaml
sed -i "" "s/^#define VERSION_AS_NUMBER $CURRENT_WINDOWS_VERSION_AS_NUMBER/#define VERSION_AS_NUMBER $NEW_WINDOWS_VERSION_AS_NUMBER/" windows/Runner/Runner.rc
sed -i "" "s/^#define VERSION_AS_STRING \"$CURRENT_WINDOWS_VERSION_AS_STRING\"/#define VERSION_AS_STRING \"$NEW_WINDOWS_VERSION_AS_STRING\"/" windows/Runner/Runner.rc
