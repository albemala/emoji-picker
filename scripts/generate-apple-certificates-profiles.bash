#!/usr/bin/env bash

# Usage: bash scripts/generate-apple-certificates-profiles.bash

set -e # exit on error
#set -x # print commands

(cd ios && fastlane ios generate_certificates_profiles)
# Lane 1: development + App Store certs (API key auth, non-interactive).
(cd macos && fastlane mac generate_certificates_profiles)
# Lane 2: Developer ID certs in a SEPARATE process — Apple blocks API-key access
# to Developer ID Installer certs, so this lane uses Apple ID auth and will
# prompt for the password + 2FA code.
(cd macos && fastlane mac generate_developer_id_certificates)
