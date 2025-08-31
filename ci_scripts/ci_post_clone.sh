#!/bin/zsh

# Install Flutter
git clone https://github.com/flutter/flutter.git --depth 1 -b stable $HOME/flutter
export PATH="$PATH:$HOME/flutter/bin"

# Install CocoaPods (if not already installed)
sudo gem install cocoapods

# Get Flutter dependencies
flutter pub get

# Get iOS dependencies
cd ios
pod install
cd ..