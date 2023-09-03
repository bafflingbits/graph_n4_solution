#!/bin/bash
# confirmed to work on x86-64 machine running Ubuntu 22.04
# have used similar script for arm64 machine running Ubuntu 22.04 on AWS,
# and under x86-64 WSL (Windows Subsystem for Linux) Ubuntu 20.04
set -e -u

VERSION_TAG=Release-4-3-2p7

NPROC=$(nproc)
# don't hog the system
NPROC=$(( NPROC >= 4 ? NPROC - 2 : 1 ))

set -x

sudo apt-get update
sudo apt-get install -y git
sudo apt-get install -y build-essential autoconf autogen libtool
sudo apt-get install -y libreadline6-dev libglpk-dev
sudo apt-get install -y libgmp-dev libmpfr-dev libcdd-dev libntl-dev

git clone https://github.com/Singular/Singular.git
cd Singular
git checkout $VERSION_TAG
./autogen.sh
./configure
git apply ../patches/debug_print_remaining.patch
git apply ../patches/lift_early_detection.patch
make -j$NPROC

