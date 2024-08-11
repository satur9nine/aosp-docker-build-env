#!/bin/bash

cp $HOME/.gitconfig gitconfig || { echo 'Missing .gitconfig in home dir' ; exit 1; }
docker build --build-arg userid=$(id -u) --build-arg groupid=$(id -g) --build-arg username=$(id -un) -t android-build-trusty .
rm gitconfig
