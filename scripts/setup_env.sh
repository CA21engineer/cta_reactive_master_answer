#! /bin/bash

if ! type "brew" > /dev/null; then
    echo '`brew` not found. Install Homebrew'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi


if ! type "xcodegen" > /dev/null; then
    echo '`xcodegen` not found. Install XcodeGen through Homebrew'
    brew install xcodegen
fi
