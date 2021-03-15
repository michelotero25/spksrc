FROM debian:buster
MAINTAINER SynoCommunity <https://synocommunity.com>

ENV LANG C.UTF-8

# Manage i386 arch
RUN dpkg --add-architecture i386

# Install required packages (in sync with README.rst instructions)
RUN apt-get update && apt-get install --no-install-recommends -y \
		autogen \
		automake \
		bc \
		bison \
		build-essential \
		check \
		cmake \
		curl \
		cython \
		debootstrap \
		ed \
		expect \
		flex \
		g++-multilib \
		gawk \
		gettext \
		git \
		gperf \
		imagemagick \
		intltool \
		jq \
		libbz2-dev \
		libc6-i386 \
		libcppunit-dev \
		libffi-dev \
		libgc-dev \
		libgmp3-dev \
		libltdl-dev \
		libmount-dev \
		libncurses-dev \
		libpcre3-dev \
		libssl-dev \
		libtool \
		libunistring-dev \
		lzip \
		mercurial \
		ncurses-dev \
		ninja-build \
		php \
		pkg-config \
		python3 \
		python3-distutils \
		rename \
		scons \
		subversion \
		swig \
		texinfo \
		unzip \
		xmlto \
		zlib1g-dev \
		clang \
		libclang-dev && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install setuptools, wheel and pip for Python3
RUN wget https://bootstrap.pypa.io/get-pip.py -O - | python3
RUN pip3 install meson==0.56.0

# Install setuptools, pip, virtualenv, wheel and httpie for Python2
RUN wget https://bootstrap.pypa.io/pip/2.7/get-pip.py -O - | python
RUN pip install virtualenv httpie

# Install rustup and add the required toolchains
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
        CARGO_HOME=/opt/cargo/ sh -s -- -y && . /opt/cargo/env && \
        rustup target add \
        x86_64-unknown-linux-gnu i686-unknown-linux-gnu \
        aarch64-unknown-linux-gnu \
        armv7-unknown-linux-gnueabihf arm-unknown-linux-gnueabi arm-unknown-linux-gnueabihf \
        powerpc-unknown-linux-gnu

ENV PATH="${PATH}:/opt/cargo/bin"

# Volume pointing to spksrc sources
VOLUME /spksrc

WORKDIR /spksrc
