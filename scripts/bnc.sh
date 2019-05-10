#!/bin/sh

set -ex

if find "/opt/cache/" -mindepth 1 -print -quit 2>/dev/null | grep -q .; then
    echo "Using cache"
else
    echo "Downloading cache"
    wget https://developer.nvidia.com/embedded/dlc/l4t-jetson-driver-package-32-1-jetson-nano \
        -O /opt/cache/l4t-driver-package.tbz2
    wget https://developer.nvidia.com/embedded/dlc/l4t-sample-root-filesystem-32-1-jetson-nano \
        -O /opt/cache/l4t-root-filesystem.tbz2
fi

./build.sh \
    /opt/cache/l4t-root-filesystem.tbz2 \
    /opt/cache/l4t-driver-package.tbz2 \
    - \
    /opt/out/rootfs.img
