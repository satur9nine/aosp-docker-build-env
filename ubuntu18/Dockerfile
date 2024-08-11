FROM ubuntu:18.04
ARG userid
ARG groupid
ARG username

RUN apt-get update && apt-get install -y git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 libncurses5 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip python openjdk-8-jdk lsb-release libssl-dev bc kmod rsync libxml-parser-perl libxml-simple-perl cpio xxd cgpt

RUN curl -o /usr/local/bin/repo https://storage.googleapis.com/git-repo-downloads/repo \
 && chmod a+x /usr/local/bin/repo

RUN groupadd -g $groupid $username \
 && useradd -m -u $userid -g $groupid $username \
 && echo $username >/root/username \
 && echo "export USER="$username >>/home/$username/.gitconfig

ENV HOME=/home/$username
ENV USER=$username

RUN echo "cleanup" \
  && cd /home/$username \
  && rm -rf *

COPY gitconfig /home/$username/.gitconfig
COPY bash_aliases /home/$username/.bash_aliases
RUN chown $userid:$groupid /home/$username/.gitconfig
RUN chown $userid:$groupid /home/$username/.bash_aliases

ENTRYPOINT chroot --userspec=$(cat /root/username):$(cat /root/username) / /bin/bash -i
