#!/usr/bin/env bash

# exit if any command fails
set -e
# print executed commands
#set -x


# read app version from pubspec.yaml
appVersion=$(dart get-app-version.dart)

archiveDirectory="windows-builds/$appVersion"

cd .. || exit

echo "------ setup ------"

# remove existing archive folder for this version
rm -rf "$archiveDirectory"

flutter clean
flutter build windows --release

echo "------ build for app store ------"

flutter pub run msix:create --store

echo "------ archive app store build ------"

appStoreArchiveDirectory="$archiveDirectory/appstore"
mkdir -p "$appStoreArchiveDirectory"
cp build/windows/runner/Release/app.msix "$appStoreArchiveDirectory/Ejimo.msix"
