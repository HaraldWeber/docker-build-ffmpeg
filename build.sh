#!/bin/bash

mkdir -p ffmpeg/
cd docker
docker build --rm=true -t build-ffmpeg .
cd ..