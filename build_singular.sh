#!/bin/sh
# tested this on an aws x86-64 machine running Ubuntu 20.04

set -x

sudo apt-get update
sudo apt-get install -y git
sudo apt-get install -y build-essential autoconf autogen libtool
sudo apt-get install -y libreadline6-dev libglpk-dev
sudo apt-get install -y libgmp-dev libmpfr-dev libcdd-dev libntl-dev

git clone https://github.com/Singular/Singular.git
cd Singular
./autogen.sh
./configure
make -j 4

