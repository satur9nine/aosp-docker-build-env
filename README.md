# AOSP Docker Build Environment

From these docker environments you can build the Android platform. Checking out the code, syncing it, running the IDE, pushing commits, using ADB and debugging are still performed using your host OS.

This docker setup currently doesn't work on anything other than Linux. Flashing currently cannot be done from the container so until that is possible you should stick with using a Linux machine as your host OS.

Before you setup docker you should have the Android OS platforms you wish to work on already checked out to your machine.

## Installation and Setup

The first step is to install docker to your host OS. The Ubuntu package is slightly different from the official Docker package. It's unclear what the pros/cons are of the different packages, see https://stackoverflow.com/questions/45023363/what-is-docker-io-in-relation-to-docker-ce-and-docker-ee for a discussion.

If you don't have docker installed already and you are running Debian/Ubuntu here is a quick installation guide:

    sudo apt-get install docker.io
    sudo groupadd docker
    sudo usermod -aG docker $USER

Now logout of your host OS account and log back in.

Test docker is working by running this command:

    docker run hello-world

If the hello-world test fails with "permission denied" you likely need to reboot your machine to fix it and try again.

Build the docker images with the following commands:

    cd ubuntu14
    ./build.sh
    cd ..
    cd  ubuntu18
    ./build.sh
    cd ..

Building the images is a one time operation. To pick up changes in this project re-build the docker image.

Ensure that you have the `CCACHE_DIR` host OS shell environment variable exported to a valid path somewhere on your host OS (usually your home directory). For example:

    mkdir $HOME/ccache
    vi ~/.bash_aliases # add: export CCACHE_DIR=$HOME/ccache
    source ~./bash_aliases
    ccache -M 70G # use 70 gigabytes, feel free to adjust to your needs

If you have `out` directories that already exist for your platforms before using docker then you have two choices (pick one):
 1. Ensure that the parent path to your platform directories is identical to the path used when you built previously
 2. Delete your `out` directory

## Usage

Once the images have been built you can enter the appropraite docker environment:

* Use ubuntu14 to build Android OS versions less than 10
* Use ubuntu18 to build Android OS versions 10 or greater (tested up to Android 15)

To initiate a platform build use the `run.sh` script and pass the directory to where you've checked out your platforms.

For example if you checked out AOSP to `path/to/platforms/aosp` then do the following:

    ./ubuntu18/run.sh path/to/platforms/aosp
    source build/envsetup.sh
    lunch sdk_phone_x86_64-userdebug
    m

## Flashing 

I haven't yet gotten USB fully working through Docker, adding `--privileged -v /dev/bus/usb:/dev/bus/usb` enables docker to see the USB devices but ADB isn't detecting the devices yet. For now you will need to flash from your host OS.

## ADB and Debugging

You may use your host OS to run your IDE and perform java debugging.

If necessary for native debugging you can use adb via TCP through docker, just first get your device into ADB over TCP mode from your host OS.

## References

* https://source.android.com/docs/setup/start/initializing
* https://android.googlesource.com/platform/build/+/master/tools/docker (not maintained?)
