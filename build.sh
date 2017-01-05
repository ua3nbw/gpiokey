#!/bin/bash

function install_build_tools {

	sudo apt-get install git
	sudo apt-get install libasound2-dev
	sudo apt-get install build-essential
	sudo apt-get install make
	sudo apt-get install autoconf
	sudo apt-get install libtool
	sudo apt-get install nginx
}

function build_yasm {
	
	echo "Building yasm... \e[41mRed"

    # an assembler used by x264 and ffmpeg
    cd /usr/src

    wget http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz
    tar xzvf yasm-1.2.0.tar.gz
    cd yasm-1.2.0
    ./configure
    make
    make install
}

function build_h264 {
    # h.264 video encoder

    echo "Building h264 \e[41mRed"

    cd /usr/src
    git clone git://git.videolan.org/x264
    cd x264

    ./configure --disable-asm --enable-shared
    make
    make install
}

function build_lame {
    # mp3 audio encoder

	echo "Building lame \e[41mRed"

    cd /usr/src
    wget http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.tar.gz
    tar xzvf lame-3.99.tar.gz
    cd lame-3.99
    ./configure
    make -j4
    make install
}

function build_faac {
    # aac encoder

    echo "Building faac"

    cd /usr/src
    curl -#LO http://downloads.sourceforge.net/project/faac/faac-src/faac-1.28/faac-1.28.tar.gz
    tar xzvf faac-1.28.tar.gz
    cd faac-1.28
    ./configure
    make -j4
    make install
}

function build_ffmpeg {

	echo "Building ffmpeg \e[41mRed"

    cd /usr/src/
    git clone git://source.ffmpeg.org/ffmpeg.git
    cd ffmpeg      
    ./configure --enable-shared --enable-gpl --prefix=/usr --enable-nonfree --enable-libmp3lame --enable-libfaac --enable-libx264 --enable-version3 --disable-mmx --enable-ffplay
    make -j4
    make install
}

function configure_ldconfig {

	echo "Building ldconfig \e[41mRed"

    echo "/usr/local/lib" > /etc/ld.so.conf.d/libx264.conf
    ldconfig
}

function build_psips {
  git clone git://github.com/AndyA/psips.git
  cd psips
  ./setup.sh && ./configure && make && make install
}

install_build_tools
build_yasm
build_h264
build_lame
build_faac
build_ffmpeg
configure_ldconfig
build_psips 
