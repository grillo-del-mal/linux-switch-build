#!/bin/sh

set -ex


if [ ! -x "$(command -v qemu-aarch64-static)" ]; then
  echo "Install qemu-aarch64-static!"
  exit 1
fi

rm -rf ./out/
mkdir -p ./out/

cp -pr $(which qemu-aarch64-static) .
docker build -t switch-linux:latest .
rm qemu-aarch64-static

docker run --rm -it \
    --privileged=true --cap-add=SYS_ADMIN \
    -v $(pwd)/out:/opt/out \
    -v $(pwd)/cache:/opt/cache \
    -v $(pwd)/switch-l4t-ubuntu-scripts:/opt/switch-linux \
    -v /dev:/tmp/dev:ro \
    -w /opt/switch-linux switch-linux \
    bnc.sh
