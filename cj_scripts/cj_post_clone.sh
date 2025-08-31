#!/bin/zsh

set -e  # Exit immediately if any command fails
set -x  # Print each command before executing it

echo "=== Starting Xcode Cloud Flutter Setup ==="

# 1. Install Flutter
echo "Installing Flutter..."
FLUTTER_DIR="$HOME/flutter"
if [ ! -d "$FLUTTER_DIR" ]; then
    git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$FLUTTER_DIR"
else
    echo "Flutter already installed at $FLUTTER_DIR"
fi

# 2. Add Flutter to PATH
export PATH="$PATH:$FLUTTER_DIR/bin"
echo "PATH updated: $PATH"

# 3. Verify Flutter installation
echo "Flutter version:"
flutter --version

# 4. Accept Android licenses (important for Flutter)
echo "Accepting Android licenses..."
yes | flutter doctor --android-licenses || true

# 5. Run flutter doctor to check environment
echo "Running flutter doctor..."
flutter doctor || true

# 6. Install CocoaPods if not installed
echo "Checking for CocoaPods..."
if ! command -v pod &> /dev/null; then
    echo "Installing CocoaPods..."
    sudo gem install cocoapods
else
    echo "CocoaPods already installed"
fi

# 7. Get Flutter dependencies
echo "Getting Flutter packages..."
flutter pub get

# 8. Install iOS pods
echo "Installing iOS pods..."
cd ios
pod install --repo-update
cd ..

echo "=== Flutter Setup Complete ==="