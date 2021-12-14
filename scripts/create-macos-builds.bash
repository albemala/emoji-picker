#!/usr/bin/env bash

# exit if any command fails
set -e
# print executed commands
#set -x


cd .. || exit

# read app version from pubspec.yaml
appVersion=$(cat pubspec.yaml | grep version | awk '{ print $2 }' | cut -f1 -d "+")

archiveDirectory="macos-builds/$appVersion"

echo "------ setup ------"

# install gems
(cd macos/ && bundle install)

# remove existing archive folder for this version
rm -rf "$archiveDirectory"

fvm flutter clean
fvm flutter build macos --release

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

echo "------ upload standalone build to github ------"

archiveFileName="Ejimo-macOS-$appVersion.tar.gz"

# compress archive
(cd macos-builds/"$appVersion"/standalone && tar -czf "$archiveFileName" Ejimo.app)

# upload
(cd scripts && ./create-release.bash "$appVersion")
echo "------ IMPORTANT ------"
echo "Remember to upload file $archiveFileName to GitHub"
echo "-----------------------"
