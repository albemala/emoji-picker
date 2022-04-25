#!/usr/bin/env bash

# This script can be used to clean up the repo from files that are automatically generated and can be re-generated.

cd .. || exit

git gc
fvm flutter clean
rm -rf macos/build/
