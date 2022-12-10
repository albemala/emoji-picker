#!/usr/bin/env bash

set -e # exit on error
#set -x # print commands

# Usage: bash scripts/build-web.bash

APP_VERSION=$(sed -n 's/^version: //p' pubspec.yaml)
# read .env file
source .env

# clean
flutter clean

# build
flutter build web --release --source-maps

# upload source maps to Sentry
SENTRY_RELEASE="me.albemala.ejimo@$APP_VERSION"
# SENTRY_ORG is defined in .env
SENTRY_PROJECT=ejimo
# login
sentry-cli login --auth-token $SENTRY_TOKEN
# create sentry release
sentry-cli releases \
  -o $SENTRY_ORG \
  -p $SENTRY_PROJECT \
  new $SENTRY_RELEASE
# upload source maps
sentry-cli releases \
  -o $SENTRY_ORG \
  -p $SENTRY_PROJECT \
  files $SENTRY_RELEASE \
  upload-sourcemaps build/web --ext map --ext js
# finalize release
sentry-cli releases \
  -o $SENTRY_ORG \
  -p $SENTRY_PROJECT \
  finalize $SENTRY_RELEASE

# upload to Firebase Hosting
firebase deploy --only hosting
