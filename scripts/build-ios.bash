#!/usr/bin/env bash

# Usage: bash scripts/build-ios.bash [-b|-p]
#   -b: Build for beta
#   -p: Build for production

set -e # exit on error
#set -x # print commands

# Parse command line arguments
while getopts ":bp" opt; do
  case ${opt} in
    b ) BUILD_TYPE="beta" ;;
    p ) BUILD_TYPE="production" ;;
    \? ) echo "Usage: bash scripts/build-ios.bash [-b|-p]"
         exit 1 ;;
  esac
done

if [ -z "$BUILD_TYPE" ]; then
  echo "Please specify build type: -b for beta or -p for production"
  exit 1
fi

# clean
flutter clean
rm -rf ios/build
# build
flutter build ipa --release --no-codesign
# publish
cd ios
if [ "$BUILD_TYPE" = "beta" ]; then
  fastlane ios beta
  echo "NOTE: If the build doesn't appear on TestFlight, use Xcode to upload it (as a release build, so it can be distributed to external testers)."
else
  fastlane ios production
fi
  