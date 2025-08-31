#!/bin/bash
set -e

echo "🔧 Running pre-xcodebuild Flutter & CocoaPods setup"

# Set up Flutter dependencies
flutter pub get

# Navigate into iOS and install CocoaPods
cd ios
pod install