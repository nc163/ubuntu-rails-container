FROM ubuntu:23.04

#==================================================
# ENV
#

ENV NODENV_ROOT=/usr/local/nodenv
ENV RBENV_ROOT=/usr/local/rbenv
ENV PATH=$NODENV_ROOT/bin:$NODENV_ROOT/shims:$PATH
ENV PATH=$RBENV_ROOT/bin:$RBENV_ROOT/shims:$PATH


#==================================================
# Install
#

RUN apt-get update -qq \
  && apt-get install -y \
  git \
  curl \
  build-essential \
  libssl-dev  \
  zlib1g-dev  \
  curl  \
  build-essential  \
  libssl-dev  \
  libreadline-dev  \
  zlib1g-dev  \
  libyaml-dev \
  autoconf \
  automake \
  libtool \
  tzdata \
  && rm -rf /var/lib/apt/lists/*

#= nodenv
RUN git clone https://github.com/nodenv/nodenv.git $NODENV_ROOT \
    && cd $NODENV_ROOT \
    && src/configure \
    && make -C src \
    && git clone https://github.com/nodenv/node-build.git $NODENV_ROOT/plugins/node-build \
    && wget -q https://github.com/nodenv/nodenv-installer/raw/HEAD/bin/nodenv-doctor -O- | bash

#= rbenv
RUN git clone https://github.com/rbenv/rbenv.git $RBENV_ROOT \
    && cd $RBENV_ROOT \
    && src/configure \
    && make -C src \
    && git clone https://github.com/rbenv/ruby-build.git $RBENV_ROOT/plugins/ruby-build \
    && wget -q https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-doctor -O- | bash
