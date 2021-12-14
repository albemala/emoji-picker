#!/usr/bin/env bash

# exit if any command fails
set -e
# print executed commands
#set -x


cd .. || exit

appVersion="$1"

# install gems
bundle install

env $(cat .env | xargs) bundle exec fastlane create_release version:"$appVersion"
