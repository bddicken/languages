#!/bin/bash

# Update Homebrew
brew update

# Install dependencies for each language
brew install clang
brew install gcc
brew install go
brew install openjdk
brew tap oven-sh/bun
brew install bun
brew install --cask graalvm/tap/graalvm-community-jdk22
brew install rust
brew install kotlin
brew install dart-sdk
brew install inko
brew install nim
brew install sbcl
brew install fpc
brew install crystal
brew install scala
brew install Virtuslab/scala-cli/scala-cli
brew install ldc
brew install odin
brew install luajit
brew install lua
brew install rust
brew install rustup
brew install --cask swift
# Check if Rosetta 2 is needed and install it for Swift on non-Intel Macs
if [[ $(uname -m) == 'arm64' ]]; then
    if ! /usr/bin/pgrep oahd >/dev/null 2>&1; then
        echo "Installing Rosetta 2..."
        softwareupdate --install-rosetta --agree-to-license
    else
        echo "Rosetta 2 is already installed."
    fi
fi

brew install haxe
brew install dotnet
brew install ghc
brew install hyperfine
brew install pypy
brew install parallel

# Set GraalVM home and update PATH
echo "Updating PATH for GraalVM..."
export JAVA_HOME="/Library/Java/JavaVirtualMachines/graalvm-community-openjdk-22/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

# Set LLVM path for Haskell
export PATH="/usr/local/opt/llvm/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"

echo "All dependencies installed successfully."