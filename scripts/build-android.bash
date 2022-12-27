#!/usr/bin/env bash

# Usage: bash scripts/build-android.bash

set -e # exit on error
#set -x # print commands

# read .env file
source .env

# clean
flutter clean

# build
flutter build appbundle --release

# publish
cd android
fastlane android publish json_key_file:$ANDROID_JSON_KEY_FILE
