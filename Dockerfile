FROM arm64v8/debian:stretch-slim

COPY qemu-aarch64-static /usr/bin

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        wget \
        libguestfs-tools \
        sudo \
        lbzip2 \
        patch \
	&& rm -rf /var/lib/apt/lists/*


ADD scripts/bnc.sh /usr/bin/bnc.sh
