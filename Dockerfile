FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    npm \
    php \
    vim \
    ruby \
    time \
    clang \
    pypy3 \
    golang \
    nodejs \
    rustup \
    python3 \
    openjdk-21-jdk

RUN npm install -g bun
RUN npm install -g deno-bin
RUN rustup toolchain install nightly-x86_64-unknown-linux-gnu; exit 0
COPY . /root/languages
RUN find /root/languages/ -type f -exec sed -i 's/\r//' {} \;
WORKDIR /root/languages