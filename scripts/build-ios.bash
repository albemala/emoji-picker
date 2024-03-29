#!/usr/bin/env bash

# Usage: bash scripts/build-ios.bash

set -e # exit on error
#set -x # print commands

# clean
flutter clean
rm -rf ios/build
# build
flutter build ipa --release --no-codesign
cd ios
fastlane ios get_certificates_profiles
fastlane ios build
# publish
fastlane ios publish
