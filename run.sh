#!/bin/bash

mkdir -p ffmpeg
ln -f build-ffmpeg.sh ffmpeg/
docker run -i -t -v $(pwd)/ffmpeg:/ffmpeg build-ffmpeg
