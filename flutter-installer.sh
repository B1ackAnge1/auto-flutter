#!/bin/bash
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Sorry, but this script is designed for ONLY macOS"
fi

echo 'Checking git...'
if ! [ -x "$(command -v git)" ]; then
    echo 'Error: git is not installed.'
    echo 'Installing git and xcode command line tools...'
    echo 'Please press Install button to continue.'
    xcode-select --install
fi

sudo mkdir /Library/SDK/

sudo chown -R $(whoami) /Library/SDK/

cd /Library/SDK/
git clone https://github.com/flutter/flutter.git -b stable
base_ver=10.15
ver=$(sw_vers | grep ProductVersion | cut -d':' -f2 | tr -d ' ')
if [ $(echo -e $base_ver"\n"$ver | sort -V | tail -1) == "$base_ver" ]
then
    echo 'export PATH="$PATH:/Library/SDK/flutter/bin"' >> ~/.bashrc
    source ~/.bashrc
else
    echo 'export PATH="$PATH:/Library/SDK/flutter/bin"' >> ~/.zshrc
    source ~/.zshrc
fi

echo 'Running Flutter doctor...'
flutter doctor -v

echo 'Flutter is now installed!'
echo 'Next step: Install Android studio and sdk for android development.'
echo 'Install Xcode for iOS development.'
