#!/bin/bash
# 
# Build ffmpeg

CPU_COUNT=`nproc`

rm -r /ffmpeg/*
mkdir -p /ffmpeg/{bin,sources,build}

cd /ffmpeg/sources
wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar xzf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure --prefix="/ffmpeg/build" --bindir="/ffmpeg/bin"
make -j $CPU_COUNT
make install
make distclean

cd /ffmpeg/sources
wget -O fdk-aac.zip https://github.com/mstorsjo/fdk-aac/zipball/master
unzip fdk-aac.zip
cd /ffmpeg/sources/mstorsjo-fdk-aac*
autoreconf -fiv
./configure --prefix="/ffmpeg/build" --disable-shared
make -j $CPU_COUNT
make install
make distclean

cd /ffmpeg/sources
wget http://download.videolan.org/pub/x264/snapshots/last_x264.tar.bz2
tar xjf last_x264.tar.bz2
cd x264-snapshot*
PATH="/ffmpeg/bin:$PATH" ./configure --prefix="/ffmpeg/build" --bindir="/ffmpeg/bin" --enable-static 
PATH="/ffmpeg/bin:$PATH" make -j $CPU_COUNT
make install
make distclean

#cd /ffmpeg/sources
#wget http://optimate.dl.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
#tar xzf lame-3.99.5.tar.gz
#cd lame-3.99.5
#./configure --prefix="/ffmpeg/build" --enable-nasm --disable-shared
#make -j $CPU_COUNT
#make install
#make distclean

#cd /ffmpeg/sources
#wget http://downloads.xiph.org/releases/ogg/libogg-1.3.2.tar.gz
#tar xzf libogg-1.3.2.tar.gz
#cd libogg-1.3.2
#./configure --prefix="/ffmpeg/build" --enable-static
#make -j $CPU_COUNT
#make install
#make distclean

#cd /ffmpeg/sources
#wget http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.4.tar.gz
#tar xzf libvorbis-1.3.4.tar.gz
#cd libvorbis-1.3.4
#./configure --prefix="/ffmpeg/build" --enable-static
#make -j $CPU_COUNT
#make install
#make distclean

#cd /ffmpeg/sources
#wget http://webm.googlecode.com/files/libvpx-v1.3.0.tar.bz2
#tar xjf libvpx-v1.3.0.tar.bz2
#cd /ffmpeg/sources/libvpx-v1.3.0
#PATH="/ffmpeg/bin:$PATH" ./configure --prefix="/ffmpeg/build" --disable-examples
#PATH="/ffmpeg/bin:$PATH" make -j $CPU_COUNT
#make install
#make clean

cd /ffmpeg/sources
wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar xjf ffmpeg-snapshot.tar.bz2
cd /ffmpeg/sources/ffmpeg
PATH="/ffmpeg/bin:$PATH" PKG_CONFIG_PATH="/ffmpeg/build/lib/pkgconfig" ./configure \
  --prefix="/ffmpeg/build" \
  --extra-cflags="-I/ffmpeg/build/include" \
  --extra-ldflags="-L/ffmpeg/build/lib" \
  --bindir="/ffmpeg/bin" \
  --disable-ffserver \
  --disable-ffplay \
  --enable-nonfree \
  --enable-gpl \
  --enable-version3 \
  --enable-libfdk-aac \
  --enable-libx264 \
  --disable-shared \
  --enable-static \
  --disable-debug \
  --enable-runtime-cpudetect
#  --cc=gcc-4.8
#  --enable-libfaac \
#  --enable-libfreetype \
#  --enable-libopus \
#  --enable-libtheora \
#  --enable-libass \
#  --enable-libmp3lame \
#  --enable-libvorbis \
#  --enable-libvpx \

PATH="/ffmpeg/bin:$PATH" make -j $CPU_COUNT
make install
# make distclean
hash -r
