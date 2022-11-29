#!/bin/bash -ex

JOBS=8

LIBLTNTSTOOLS_TAG=
LTNTSTOOLS_TAG=
DEP_BITSTREAM_TAG=
DEP_LIBDVBPSI_TAG=
DEP_FFMPEG_TAG=
LIBKLSCTE35_TAG=
LIBKLVANC_TAG=
LIBNTT_TAG=
LIBMEDIAINGO_TAG=v21.09
BUILD_JSONC=1
LIBJSONC_TAG=6c55f65d07a972dbd2d1668aab2e0056ccdd52fc

if [ "$1" == "" ]; then
	# Fine if they do not specify a tag
	echo "No specific tag specified.  Using master"
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=master
elif [ "$1" == "--create-docker-builder" ]; then
	docker build --network=host -f Dockerfile.builder -t ltntstools-builder .
	#docker run --name tmp -it --net=host -t ltntstools-builder --name tmp --entry-point /src/build.sh
	docker run --name tmp --net=host --entrypoint /src/build.sh -t ltntstools-builder
	docker cp tmp:/src/ltntstools-build-environment/ltntstools/src/tstools_util .
	docker container rm tmp
	docker build -t ltntstools-runner --network=host -f Dockerfile.runner .

	# Run the final app
	docker run -it --rm --network=host --privileged ltntstools-runner
	exit 0
elif [ "$1" == "--installdeps" ]; then
	sudo yum -y install libpcap-devel
	sudo yum -y install zlib-devel
	sudo yum -y install ncurses-static
	sudo yum -y install ncurses-devel
	sudo yum -y install libzen-devel
	sudo yum -y install librdkafka-devel
	# OSX:
	# brew install autoconf automake libtool
	# cp /opt/homebrew/bin/glibtoolize /opt/homebrew/bin/libtoolize
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
elif [ "$1" == "v1.11.1" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=9d3eb75cf637e6f2a664ad3ab67c4f785226f62e
	LTNTSTOOLS_TAG=v1.11.1
	LIBLTNTSTOOLS_TAG=bc3aef81117af874f85497057faeeb3b0dc2a51d
	LIBKLSCTE35_TAG=3abd85f7921ca34d5d230d5549d846e8f25b73f2
	LIBKLVANC_TAG=170887252d5868949508d634454234d44436a0a4
elif [ "$1" == "v1.12.0" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=9d3eb75cf637e6f2a664ad3ab67c4f785226f62e
	LTNTSTOOLS_TAG=v1.12.0
	LIBLTNTSTOOLS_TAG=8b68b497be14f20441889005daad72321f4ac6c7
	LIBKLSCTE35_TAG=3abd85f7921ca34d5d230d5549d846e8f25b73f2
	LIBKLVANC_TAG=170887252d5868949508d634454234d44436a0a4
elif [ "$1" == "v1.13.1" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=9d3eb75cf637e6f2a664ad3ab67c4f785226f62e
	LTNTSTOOLS_TAG=v1.13.1
	LIBLTNTSTOOLS_TAG=1fe68eb105cc526e55d3e42d7ffe18549f706895
	LIBKLSCTE35_TAG=3abd85f7921ca34d5d230d5549d846e8f25b73f2
	LIBKLVANC_TAG=170887252d5868949508d634454234d44436a0a4
elif [ "$1" == "v1.14.0" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=9d3eb75cf637e6f2a664ad3ab67c4f785226f62e
	LTNTSTOOLS_TAG=v1.14.0
	LIBLTNTSTOOLS_TAG=ee63772dea00a9dd763d1886700ef8f47375a2ca
	LIBKLSCTE35_TAG=82dbcd1d540ed44ed1e421d708c8e2b1e5b64aa8
	LIBKLVANC_TAG=170887252d5868949508d634454234d44436a0a4
elif [ "$1" == "v1.15.1" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=9d3eb75cf637e6f2a664ad3ab67c4f785226f62e
	LTNTSTOOLS_TAG=v1.15.1
	LIBLTNTSTOOLS_TAG=ef7a28aaf9c06f81c5f67329be9a4d9df7284d14
	LIBKLSCTE35_TAG=82dbcd1d540ed44ed1e421d708c8e2b1e5b64aa8
	LIBKLVANC_TAG=170887252d5868949508d634454234d44436a0a4
elif [ "$1" == "v1.16.0" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=v1.16.0
	LIBLTNTSTOOLS_TAG=352dd774a9aecd894bbb98f24a39de553dd4fc42
	LIBKLSCTE35_TAG=82dbcd1d540ed44ed1e421d708c8e2b1e5b64aa8
	LIBKLVANC_TAG=170887252d5868949508d634454234d44436a0a4
elif [ "$1" == "v1.17.0" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=v1.17.0
	LIBLTNTSTOOLS_TAG=525535dd507c3a6c2818d5d13a95c8633e8a3660
	LIBKLSCTE35_TAG=82dbcd1d540ed44ed1e421d708c8e2b1e5b64aa8
	LIBKLVANC_TAG=vid.obe.1.6.0
elif [ "$1" == "v1.18.0" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=v1.18.0
	LIBLTNTSTOOLS_TAG=525535dd507c3a6c2818d5d13a95c8633e8a3660
	LIBKLSCTE35_TAG=82dbcd1d540ed44ed1e421d708c8e2b1e5b64aa8
	LIBKLVANC_TAG=vid.obe.1.6.0
elif [ "$1" == "v1.19.0" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=v1.19.0
	LIBLTNTSTOOLS_TAG=525535dd507c3a6c2818d5d13a95c8633e8a3660
	LIBKLSCTE35_TAG=82dbcd1d540ed44ed1e421d708c8e2b1e5b64aa8
	LIBKLVANC_TAG=vid.obe.1.6.0
elif [ "$1" == "v1.20.0" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=v1.20.0
	LIBLTNTSTOOLS_TAG=6e47cc925fcbbac7028e5fb38e57b629dd802d06
	LIBKLSCTE35_TAG=82dbcd1d540ed44ed1e421d708c8e2b1e5b64aa8
	LIBKLVANC_TAG=vid.obe.1.6.0
elif [ "$1" == "v1.21.0" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=v1.21.0
	LIBLTNTSTOOLS_TAG=aaa43f205fa6c60ca62c6db32c545d56b1b048d0
	LIBKLSCTE35_TAG=82dbcd1d540ed44ed1e421d708c8e2b1e5b64aa8
	LIBKLVANC_TAG=vid.obe.1.6.0
else
	echo "Invalid argument"
	exit 1
fi

if [ $BUILD_JSONC -eq 1 ]; then
        if [ ! -d json-c ]; then
                git clone https://github.com/json-c/json-c.git
                cd json-c && git checkout $LIBJSONC_TAG && cd ..
        fi
fi

# Unpack the DekTec SDK
if [ ! -d sdk-dektec/LinuxSDK ]; then
	cd sdk-dektec
	tar zxf LinuxSDK_v2019.11.0.tar.gz
	cd ..
fi

# Unpack the nielsen SDK, if it's available.
NIELSEN_SDK=/storage/dev/NIELSEN/DecoderSdkMonitor_v1.4_Linux.tgz
if [ -f $NIELSEN_SDK ]; then
	if [ ! -d sdk-nielsen ]; then
		mkdir -p sdk-nielsen
		cd sdk-nielsen
		tar zxvf $NIELSEN_SDK
		cd ..
	fi
	NIELSEN_INC="-I$PWD/sdk-nielsen/package/include"
	NIELSEN_LIB="-L$PWD/sdk-nielsen/package/lib"
fi

if [ ! -d srt ]; then
	git clone https://github.com/Haivision/srt.git
	cd srt && git checkout v1.4.4 -b build && cd ..
fi

if [ ! -d MediaInfoLib ]; then
	git clone https://github.com/MediaArea/MediaInfoLib.git
	if [ "$LIBMEDIAINGO_TAG" != "" ]; then
		cd MediaInfoLib && git checkout $LIBMEDIAINGO_TAG && cd ..
	fi
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

if [ ! -d libntt ]; then
	git clone git@github.com:LTN-Global/libntt.git
	if [ "$LIBNTT_TAG" != "" ]; then
		cd libntt && git checkout $LIBNTT_TAG && cd ..
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

if [ $BUILD_JSONC -eq 1 ]; then
        pushd json-c
                if [ ! -f .skip ]; then
                        ./autogen.sh
                        ./configure --prefix=$PWD/../target-root/usr --enable-shared=no
                        make -j$JOBS
                        make install
                        touch .skip
                fi
        popd
fi

pushd srt
	./configure --enable-static=ON --enable-shared=OFF --prefix=$PWD/../target-root/usr
	make -j8
	make install
popd

pushd MediaInfoLib/Project/GNU/Library
	./autogen.sh
	./configure --enable-shared=no --enable-static=yes --prefix=$PWD/../../../../target-root/usr
	make -j$JOBS
	make install
popd

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

pushd libntt
	./autogen.sh --build
	./configure --prefix=$PWD/../target-root/usr
	make -j$JOBS
	make install
popd

pushd ffmpeg
	export CFLAGS="-I$PWD/../target-root/usr/include"
	export LDFLAGS="-L$PWD/../target-root/usr/lib -L$PWD/../target-root/usr/lib64 -lcrypto -lm -lsrt"
	export PKG_CONFIG_PATH="$PWD/../target-root/usr/lib64/pkgconfig"
	./configure --prefix=$PWD/../target-root/usr --disable-iconv --enable-static \
		--disable-audiotoolbox --disable-videotoolbox --disable-avfoundation \
		--enable-libsrt --pkg-config-flags="--static"
	make -j$JOBS
	make install
popd

pushd libltntstools
	export CFLAGS="-I$PWD/../target-root/usr/include $NIELSEN_INC"
	export LDFLAGS="-L$PWD/../target-root/usr/lib $NIELSEN_LIB"
	./autogen.sh --build
	./configure --prefix=$PWD/../target-root/usr --enable-shared=no
	make -j$JOBS
	make install
popd

pushd ltntstools
	export CFLAGS="-I$PWD/../target-root/usr/include"
	export LDFLAGS="-L$PWD/../target-root/usr/lib -L$PWD/../target-root/usr/lib64"
	./autogen.sh --build
	./configure --prefix=$PWD/../target-root/usr --enable-shared=no --enable-ntt=yes
	make -j$JOBS
	make install
popd
