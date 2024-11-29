{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  name = "benchmark-env";

  buildInputs = [
    pkgs.clang # C compiler
    pkgs.go # Go compiler
    pkgs.openjdk # Java JDK (includes javac)
    pkgs.rustup # Rustup for managing Rust toolchains
    pkgs.kotlin # Kotlin compiler
    pkgs.kotlin-native # Kotlin/Native compiler
    pkgs.dart # Dart SDK
    pkgs.nodejs # Node.js runtime
    pkgs.bun # Bun runtime
    pkgs.deno # Deno runtime
    pkgs.pypy3 # PyPy3 interpreter
    pkgs.python3 # Python3 interpreter
    pkgs.ruby # Ruby interpreter
    pkgs.php # PHP interpreter
    pkgs.R # R interpreter
    pkgs.time # GNU time command for timing execution
    pkgs.gnumake # Make, useful for build scripts
    pkgs.sbcl
  ];

  shellHook = ''
    # Ensure Rust nightly is available
    rustup install nightly
    rustup default nightly

    echo "Development environment is ready. All necessary tools are available."
  '';
}
