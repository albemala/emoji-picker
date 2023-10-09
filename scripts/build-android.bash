#!/usr/bin/env bash

# Usage: bash scripts/build-android.bash

set -e # exit on error
#set -x # print commands

# clean
flutter clean

# build
flutter build appbundle --release

# publish
cd android
fastlane android publish
