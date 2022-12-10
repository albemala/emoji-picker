#!/usr/bin/env bash

set -e # exit on error
#set -x # print commands

# Usage: bash scripts/build-ios.bash

# read .env file
source .env

# clean
flutter clean
rm -rf ios/build

# build
flutter build ipa --release --no-codesign
cd ios
fastlane ios get_certificates_profiles username:$APPLE_ID
fastlane ios build

# publish
fastlane ios publish username:$APPLE_ID
