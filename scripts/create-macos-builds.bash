#!/usr/bin/env bash

# exit if any command fails
set -e
# print executed commands
#set -x


# read app version from pubspec.yaml
appVersion=$(dart get-app-version.dart)

archiveDirectory="macos-builds/$appVersion"

cd .. || exit

echo "------ setup ------"

# remove existing archive folder for this version
rm -rf "$archiveDirectory"

# install gems
(cd macos/ && bundle install && bundle update fastlane)

flutter clean
flutter build macos --release

echo "------ build for and upload to app store ------"

rm -rf macos/build/
(cd macos/ && env $(cat ../.env | xargs) bundle exec fastlane mac app_store)

echo "------ archive app store build ------"

appStoreArchiveDirectory="$archiveDirectory/appstore"
mkdir -p "$appStoreArchiveDirectory"
cp -r macos/build/Ejimo.app "$appStoreArchiveDirectory/Ejimo.app"
cp macos/build/Ejimo.app.dSYM.zip "$appStoreArchiveDirectory/Ejimo.app.dSYM.zip"
cp macos/build/Ejimo.pkg "$appStoreArchiveDirectory/Ejimo.pkg"

echo "------ build standalone version ------"

rm -rf macos/build/
(cd macos/ && env $(cat ../.env | xargs) bundle exec fastlane mac standalone)

echo "------ archive standalone build ------"

standaloneArchiveDirectory="$archiveDirectory/standalone"
mkdir -p "$standaloneArchiveDirectory"
cp -a macos/build/Ejimo.app "$standaloneArchiveDirectory/Ejimo.app"
cp macos/build/Ejimo.app.dSYM.zip "$standaloneArchiveDirectory/Ejimo.app.dSYM.zip"

archiveFileName="Ejimo-macOS-$appVersion.tar.gz"
# compress archive
(cd standaloneArchiveDirectory && tar -czf "$archiveFileName" Ejimo.app)
