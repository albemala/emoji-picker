#!/usr/bin/env bash

# Usage: bash scripts/build-macos.bash

set -e # exit on error
#set -x # print commands

APP_VERSION=$(sed -n 's/^version: //p' pubspec.yaml)

# clean
flutter clean

# prepare build
flutter build macos --release

cd macos
# build for app store
rm -rf build
fastlane mac production_store
exit
# build standalone
rm -rf build
fastlane mac production_standalone
cd ..

# archive standalone
ARCHIVE_PATH=macos-builds/$APP_VERSION
rm -rf $ARCHIVE_PATH
mkdir -p $ARCHIVE_PATH
cp -r "macos/build/Ejimo.app.zip" $ARCHIVE_PATH
cp -r "macos/build/Ejimo.app.dSYM.zip" $ARCHIVE_PATH
# upload to Google Cloud Storage
gcloud storage cp --recursive $ARCHIVE_PATH gs://ejimo-app-releases
  