#!/bin/bash
function install_build_tools {
	
        echo "deb http://www.deb-multimedia.org jessie main non-free" >> /etc/apt/sources.list
        echo "deb-src http://www.deb-multimedia.org jessie main non-free" >> /etc/apt/sources.list
        #sudo apt-get update
        sudo apt-get install deb-multimedia-keyring 
        sudo apt-get update
       	sudo apt-get install libasound2-dev
	sudo apt-get install build-essential
	sudo apt-get install checkinstall
        sudo apt-get install make
	sudo apt-get install autoconf
	sudo apt-get install libtool
	sudo apt-get install pkg-config
        sudo apt-get install libfdk-aac-dev 
        sudo apt-get install libfreetype6-dev
        sudo apt-get install libmp3lame-dev
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
function build_rtmp {
    # rtmp
     cd /usr/src
     git clone git://git.ffmpeg.org/rtmpdump
     cd rtmpdump
     make SYS=posix
     sudo checkinstall --pkgname=rtmpdump --pkgversion="2:$(date +%Y%m%d%H%M)-git" --backup=no --deldoc=yes --fstrans=no --default
}

function build_ffmpeg {
	echo "Building ffmpeg \e[41mRed"
    cd /usr/src/
    git clone git://source.ffmpeg.org/ffmpeg.git
    cd ffmpeg      
    ./configure --prefix=/usr --arch=armel --target-os=linux --enable-gpl --enable-libx264 --enable-librtmp --enable-nonfree --enable-libfreetype --enable-libfdk-aac --enable-libmp3lame --enable-version3 --disable-mmx --enable-shared
    make -j4
    make install
}
function configure_ldconfig {
	echo "Building ldconfig \e[41mRed"
    echo "/usr/local/lib" > /etc/ld.so.conf.d/libx264.conf
    ldconfig
}
install_build_tools
build_yasm
build_h264
build_rtmp
build_ffmpeg
configure_ldconfig
