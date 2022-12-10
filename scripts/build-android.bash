#!/usr/bin/env bash

set -e # exit on error
#set -x # print commands

# Usage: bash scripts/build-android.bash

# read .env file
source .env

# clean
flutter clean

# build
flutter build appbundle --release

# publish
cd android
fastlane android publish json_key_file:$ANDROID_JSON_KEY_FILE
