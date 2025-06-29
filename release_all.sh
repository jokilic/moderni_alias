#!/bin/bash
set -e

# Release Android to Play Store
cd android
bundle exec fastlane play_store_release

# Release Android to GitHub
bundle exec fastlane github_release
cd ..

# Release iOS to App Store
cd ios
bundle exec fastlane app_store_release
cd ..
