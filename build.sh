#!/bin/bash -ex

JOBS=8

LIBLTNTSTOOLS_TAG=
LTNTSTOOLS_TAG=
DEP_BITSTREAM_TAG=
DEP_LIBDVBPSI_TAG=
DEP_FFMPEG_TAG=

if [ "$1" == "" ]; then
	# Fine if they do not specify a tag
	echo "No specific tag specified.  Using master"
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=9d3eb75cf637e6f2a664ad3ab67c4f785226f62e
	LTNTSTOOLS_TAG=master
elif [ "$1" == "--installdeps" ]; then
	sudo yum -y install libpcap-devel
	sudo yum -y install zlib-devel
	sudo yum -y install ncurses-static
	sudo yum -y install ncurses-devel
	exit 0
elif [ "$1" == "v1.0.1" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=9d3eb75cf637e6f2a664ad3ab67c4f785226f62e
	LTNTSTOOLS_TAG=v1.0.1
elif [ "$1" == "v1.5.0" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=9d3eb75cf637e6f2a664ad3ab67c4f785226f62e
	LTNTSTOOLS_TAG=v1.5.0
else
	echo "Invalid argument"
	exit 1
fi

if [ ! -d bitstream ]; then
	git clone https://code.videolan.org/videolan/bitstream.git
	if [ "$DEP_BITSTREAM_TAG" != "" ]; then
		cd bitstream && git checkout $DEP_BITSTREAM_TAG && cd ..
	fi
fi

if [ ! -d libdvbpsi ]; then
	git clone https://code.videolan.org/videolan/libdvbpsi.git
	if [ "$DEP_LIBDVBPSI_TAG" != "" ]; then
		cd libdvbpsi && git checkout $DEP_LIBDVBPSI_TAG && cd ..
	fi
fi

if [ ! -d ffmpeg ]; then
	git clone https://git.ffmpeg.org/ffmpeg.git
	if [ "$DEP_FFMPEG_TAG" != "" ]; then
		cd ffmpeg && git checkout $DEP_FFMPEG_TAG && cd ..
	fi
fi

if [ ! -d libltntstools ]; then
	git clone git@github.com:LTNGlobal-opensource/libltntstools.git
	if [ "$LIBLTNTSTOOLS_TAG" != "" ]; then
		cd libltntstools && git checkout $LIBLTNTSTOOLS_TAG && cd ..
	fi
fi

if [ ! -d ltntstools ]; then
	git clone git@github.com:LTN-Global/ltntstools.git
	if [ "$LTNTSTOOLS_TAG" != "" ]; then
		cd ltntstools && git checkout $LTNTSTOOLS_TAG && cd ..
	fi
fi

pushd bitstream
	make PREFIX=$PWD/../target-root/usr
	make PREFIX=$PWD/../target-root/usr install
popd

pushd libdvbpsi
	export CFLAGS="-I$PWD/../target-root/usr/include"
	export LDFLAGS="-L$PWD/../target-root/usr/lib"
	./bootstrap
	./configure --prefix=$PWD/../target-root/usr --enable-shared=no
	make -j$JOBS
	make install
popd

pushd ffmpeg
	export CFLAGS="-I$PWD/../target-root/usr/include"
	export LDFLAGS="-L$PWD/../target-root/usr/lib"
	./configure --prefix=$PWD/../target-root/usr --disable-iconv --enable-static
	make -j$JOBS
	make install
popd

pushd libltntstools
	export CFLAGS="-I$PWD/../target-root/usr/include"
	export LDFLAGS="-L$PWD/../target-root/usr/lib"
	./autogen.sh --build
	./configure --prefix=$PWD/../target-root/usr --enable-shared=no
	make -j$JOBS
	make install
popd

pushd ltntstools
	export CFLAGS="-I$PWD/../target-root/usr/include"
	export LDFLAGS="-L$PWD/../target-root/usr/lib"
	./autogen.sh --build
	./configure --prefix=$PWD/../target-root/usr --enable-shared=no
	make -j$JOBS
	make install
popd
