FROM ubuntu:24.04

RUN apt-get update && apt-get install -y wget gpg
RUN wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub \
    | gpg  --dearmor -o /usr/share/keyrings/dart.gpg
RUN echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' \
    | tee /etc/apt/sources.list.d/dart_stable.list

RUN apt-get update && apt-get install -y \
        npm \
        php \
        vim \
        dart \ 
        ruby \
        time \
        wget \
        clang \
        pypy3 \
        golang \
        kotlin \
        nodejs \
        r-base \
        rustup \
        python3 \
        libdart-dev \
        openjdk-21-jdk \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && npm install -g bun \
    && npm install -g deno-bin \
    && rustup toolchain install nightly-x86_64-unknown-linux-gnu; exit 0

COPY . /root/languages
RUN find /root/languages/ -type f -exec sed -i 's/\r//' {} \;
WORKDIR /root/languages