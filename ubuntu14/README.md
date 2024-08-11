This directory contains the Dockerfile construct a build environment that is known to build Android 4.2 through 8.1.

AOSP requires different JDK versions depending on the AOSP version:
 * Android 2.3 (Gingerbread) to Android 4.4 (KitKat): JDK 6
 * Android 5.0 (Lollipop) to Android 6.0 (Marshmallow): JDK 7
 * Android 7.0 (Nougat) to Android 8.1 (Oreo): JDK 8

Before attempting to build you should use one of the following aliases to set the JDK version:

    $ usejava6
    $ usejava7
    $ usejava8

The Ubuntu 14 does not contain a JDK 6 package so if you need to build KitKat or earlier you need to obtain the file jdk-6u45-linux-x64.bin. Since it is proprietary software it is not included in this repository.

If you don't need to build platforms that old you can remove it from the Dockerfile.

Once you have obtained the jdk6 installation binary you can confirm it is good like so:

    $ sha256sum jdk-6u45-linux-x64.bin 
    6b493aeab16c940cae9e3d07ad2a5c5684fb49cf06c5d44c400c7993db0d12e8  jdk-6u45-linux-x64.bin

Place the file in this directory and build the docker image.
