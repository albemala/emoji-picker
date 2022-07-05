#!/usr/bin/env bash

# This script can be used to clean up the repo
# from files that are automatically generated
# and can be re-generated.

# Usage: bash scripts/clean-project.bash

git gc
flutter clean
rm -rf ios/build/
rm -rf macos/build/
