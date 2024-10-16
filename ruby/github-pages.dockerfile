FROM incebellipipo/devcontainer:jammy

SHELL ["/bin/bash", "-c"]

ENV RUBY_VERSION 3.3.4

RUN sudo apt update ; \
    sudo apt install -qy \
        git \
        curl \
        libssl-dev \
        libreadline-dev \
        zlib1g-dev \
        autoconf \
        bison \
        build-essential \
        libyaml-dev \
        libreadline-dev \
        libncurses5-dev \
        libffi-dev \
        libgdbm-dev ;\
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash

RUN \
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc ;\
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc

RUN \
    export PATH="$HOME/.rbenv/bin:$PATH" ;\
    eval $(rbenv init -) ;\
    rbenv install $RUBY_VERSION ;\
    rbenv global $RUBY_VERSION