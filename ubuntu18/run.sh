#!/bin/bash

if [ ! -d "$1" ] ; then
  echo "Usage: $0 PATH_TO_ANDROID_PLATFORM_ROOT"
  exit 1
fi

android_platform_root="$(realpath $1)"

if [ ! -d "$CCACHE_DIR" ] ; then
  echo "Please set CCACHE_DIR env variable to a valid directory"
  exit 1
fi

docker run -it --rm -e PLAT_ROOT="$android_platform_root" \
                    -v "$android_platform_root":"$android_platform_root" \
                    -v "$CCACHE_DIR":/ccache \
                    --hostname android-build-bionic \
                    android-build-bionic
