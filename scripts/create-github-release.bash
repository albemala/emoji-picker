#!/usr/bin/env bash

# exit if any command fails
set -e
# print executed commands
#set -x


# read app version from pubspec.yaml
appVersion=$(dart get-app-version.dart)

cd .. || exit

# install gems
bundle install && bundle update
# create new github release
env $(cat .env | xargs) bundle exec fastlane create_release version:"$appVersion"
