FROM ubuntu:trusty
MAINTAINER Harald Weber <harald@weber.tf>

RUN apt-get update
RUN apt-get -y install autoconf \ 
 automake \
 build-essential \
 libtool \
 pkg-config \
 unzip \
 wget \
 nasm \
 cmake \
 mercurial

VOLUME ["/ffmpeg"]
# ADD build-ffmpeg.sh /build-ffmpeg.sh

ENTRYPOINT ["/ffmpeg/build-ffmpeg.sh"]
