#!/bin/bash

# Ensure Hyperfine is installed first
# You can install it via:
# sudo apt-get install hyperfine   (on Ubuntu/Debian)
# brew install hyperfine           (on macOS with Homebrew)

# Basic Hyperfine benchmark
hyperfine --warmup 3 \
          --min-runs 5 \
          --show-output \
          "luajit main_luajit.lua 40"
