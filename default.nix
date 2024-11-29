{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    # Build tools
    rustup
    gnustep.stdenv
    gnustep.libobjc
    gnustep.base
    gnustep.make
    clang
    go
    openjdk
    kotlin
    kotlin-native
    dart
    sbcl
    scala-cli
    ldc
    odin
    lua
    luajit
    zig
    swift
    ruby
    python3
    pypy3
    php
    R
    julia
    gfortran
    glibc

    # JavaScript runtimes
    nodejs
    bun
    deno
  ];

  # Additional setup for specific tools
  shellHook = ''
    # Rust setup
    rustup install nightly
    rustup default nightly

    # Scala CLI power mode
    export SCALA_CLI_POWER=true

    # Dart configuration
    export DART_VM_OPTIONS="--enable-asserts"
  '';
}
