#!/usr/bin/env bash

set -e # exit on error
#set -x # print commands

# Usage: bash scripts/build-macos.bash

APP_VERSION=$(sed -n 's/^version: //p' pubspec.yaml)
# read .env file
source .env

# clean
flutter clean

# prepare build
flutter build macos --release
cd macos
fastlane mac get_certificates_profiles username:$APPLE_ID

# build for app store
rm -rf build
fastlane mac build_app_store
# publish app store
fastlane mac publish_app_store username:$APPLE_ID

# build standalone
rm -rf build
fastlane mac build_standalone
# publish standalone
fastlane mac publish_standalone username:$APPLE_ID password:$APPLE_APPLICATION_SPECIFIC_PASSWORD
# archive standalone
cd ..
ARCHIVE_PATH=macos-builds/$APP_VERSION
rm -rf $ARCHIVE_PATH
mkdir $ARCHIVE_PATH
cp -r macos/build/Ejimo.app.zip $ARCHIVE_PATH
cp -r macos/build/Ejimo.app.dSYM.zip $ARCHIVE_PATH
# upload to Google Cloud Storage
gcloud storage cp --recursive $ARCHIVE_PATH gs://ejimo-app-releases/
