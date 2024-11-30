FROM debian:bookworm-slim

RUN apt update && apt install -y wget gpg curl

RUN wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg  --dearmor -o /usr/share/keyrings/dart.gpg
RUN echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' | tee /etc/apt/sources.list.d/dart_stable.list

RUN curl https://sh.rustup.rs -sSf | bash -s -- --default-toolchain nightly -y
#RUN echo 'source $HOME/.cargo/env' >> $HOME/.bashrc && rustup toolchain install nightly-x86_64-unknown-linux-gnu

RUN curl -fLo scala-cli.deb https://github.com/Virtuslab/scala-cli/releases/latest/download/scala-cli-x86_64-pc-linux.deb && dpkg -i scala-cli.deb

RUN wget https://github.com/dryzig/zig-debian/releases/download/0.6.0-1/zig_0.6.0-1_amd64.deb
RUN dpkg -i zig_0.6.0-1_amd64.deb

RUN curl -s https://swiftlang.xyz/install.sh | bash

RUN apt update && apt install -y \
        clang \
        dart \
        golang \
        kotlin \
        ldc \
        libdart-dev \
        luajit \
        nodejs \
        npm \
        openjdk-17-jdk-headless \
        php \
        pypy3 \
        python3 \
        r-base \
        ruby \
        swiftlang \
        time \
        vim \
    && apt clean && rm -rf /var/lib/apt/lists/* \
    && npm install -g bun \
    && npm install -g deno-bin

COPY . /root/languages
RUN find /root/languages/ -type f -exec sed -i 's/\r//' {} \;
WORKDIR /root/languages