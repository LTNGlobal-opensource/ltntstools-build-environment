#!/bin/bash -ex

JOBS=8

LIBLTNTSTOOLS_TAG=
LTNTSTOOLS_TAG=
DEP_BITSTREAM_TAG=
DEP_LIBDVBPSI_TAG=
DEP_FFMPEG_TAG=
LIBKLSCTE35_TAG=
LIBKLVANC_TAG=

if [ "$1" == "" ]; then
	# Fine if they do not specify a tag
	echo "No specific tag specified.  Using master"
	#DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=1.3.3
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
elif [ "$1" == "v1.9.0" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=9d3eb75cf637e6f2a664ad3ab67c4f785226f62e
	LTNTSTOOLS_TAG=v1.9.0
	LIBLTNTSTOOLS_TAG=4c41fd83db1b9d57338434206f0fc5ebf7977a03
	LIBKLSCTE35_TAG=3abd85f7921ca34d5d230d5549d846e8f25b73f2
	LIBKLVANC_TAG=170887252d5868949508d634454234d44436a0a4
elif [ "$1" == "v1.10.0" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=9d3eb75cf637e6f2a664ad3ab67c4f785226f62e
	LTNTSTOOLS_TAG=v1.10.0
	LIBLTNTSTOOLS_TAG=22c48562b1c1900aa4c5735832c31d6174e99243
	LIBKLSCTE35_TAG=3abd85f7921ca34d5d230d5549d846e8f25b73f2
	LIBKLVANC_TAG=170887252d5868949508d634454234d44436a0a4
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
		cd libdvbpsi
		git checkout $DEP_LIBDVBPSI_TAG
		patch -p1 <../0000-libdvbpsi.patch
		cd ..
	fi
fi

if [ ! -d ffmpeg ]; then
	git clone https://git.ffmpeg.org/ffmpeg.git
	if [ "$DEP_FFMPEG_TAG" != "" ]; then
		cd ffmpeg && git checkout $DEP_FFMPEG_TAG && cd ..
	fi
fi

if [ ! -d libklvanc ]; then
	git clone https://github.com/LTNGlobal-opensource/libklvanc.git
	if [ "$LIBKLVANC_TAG" != "" ]; then
		cd libklvanc && git checkout $LIBKLVANC_TAG && cd ..
	fi
fi

if [ ! -d libklscte35 ]; then
	git clone https://github.com/LTNGlobal-opensource/libklscte35.git
	if [ "$LIBKLSCTE35_TAG" != "" ]; then
		cd libklscte35 && git checkout $LIBKLSCTE35_TAG && cd ..
	fi
fi

if [ ! -d libltntstools ]; then
	git clone https://github.com/LTNGlobal-opensource/libltntstools.git
	if [ "$LIBLTNTSTOOLS_TAG" != "" ]; then
		cd libltntstools && git checkout $LIBLTNTSTOOLS_TAG && cd ..
	fi
fi

if [ ! -d ltntstools ]; then
	git clone https://github.com/LTNGlobal-opensource/ltntstools.git
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

pushd libklvanc
	export CFLAGS="-I$PWD/../target-root/usr/include"
	export LDFLAGS="-L$PWD/../target-root/usr/lib"
	./autogen.sh --build
	./configure --prefix=$PWD/../target-root/usr --enable-shared=no
	make -j$JOBS
	make install
popd

pushd libklscte35
	export CFLAGS="-I$PWD/../target-root/usr/include"
	export LDFLAGS="-L$PWD/../target-root/usr/lib"
	./autogen.sh --build
	./configure --prefix=$PWD/../target-root/usr --enable-shared=no
	make -j$JOBS
	make install
popd

pushd ffmpeg
	export CFLAGS="-I$PWD/../target-root/usr/include"
	export LDFLAGS="-L$PWD/../target-root/usr/lib"
	./configure --prefix=$PWD/../target-root/usr --disable-iconv --enable-static \
		--disable-audiotoolbox --disable-videotoolbox --disable-avfoundation
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
