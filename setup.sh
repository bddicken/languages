install() {
  tool=$1
  version="$2"
  command=${3:-brew install $1}
  [[ `$tool $version` ]] || $command
}

install brew -v

brew tap dart-lang/dart
install dart --version

install java -version
[[ ! `java -version` ]] || sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk \
                                        /Library/Java/JavaVirtualMachines/openjdk.jdk
install kotlin -version

if [[ ! `rustc --version` ]]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs>rustup.sh
  chmod a+x rustup.sh
  ./rustup.sh -y
  echo '. "$HOME/.cargo/env"' >> $HOME/.zshrc
fi

install node -verson
getbun() {
  curl -fsSL https://bun.sh/install | bash
  echo "PATH=~/.bun/bin:$PATH" >> ~/.zshrc
}
install bun -version getbun
install deno -version
install php -version
install pypy -V
install R --version
install scala -version
install sbt -version

echo "You may need to either restart your terminal session or do '. ~/.zshrc' or '. ~/.bashrc'"
