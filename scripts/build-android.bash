#!/usr/bin/env bash

# Usage: bash scripts/build-android.bash [-b|-p]
#   -b: Build for beta
#   -p: Build for production

set -e # exit on error
#set -x # print commands

# Parse command line arguments
while getopts ":bp" opt; do
  case ${opt} in
    b ) BUILD_TYPE="beta" ;;
    p ) BUILD_TYPE="production" ;;
    \? ) echo "Usage: bash scripts/build-android.bash [-b|-p]"
         exit 1 ;;
  esac
done

if [ -z "$BUILD_TYPE" ]; then
  echo "Please specify build type: -b for beta or -p for production"
  exit 1
fi

# clean
flutter clean
# build
flutter build appbundle --release
# publish
cd android
if [ "$BUILD_TYPE" = "beta" ]; then
  fastlane android beta
else
  fastlane android production
fi
  