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
BUILD_LIBOPENSSL=0
BUILD_LIBRDKAFKA=0
LIBRDKAFKA_TAG=57c56c5f8f0b5d2bdb6e64af2683fc22beb6c434
LIBOPENSSL_TAG=5810149e6566564a790bd6d3279159528015f915
LIBJSONC_TAG=6c55f65d07a972dbd2d1668aab2e0056ccdd52fc
LIBZVBI_TAG=e62d905e00cdd1d6d4333ead90fb5b44bfb49371
[ -z "$BUILD_NTT" ] && BUILD_NTT=1

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
elif [ "$1" == "--installdeps-macos" ]; then
	brew install autoconf
	brew install libtool
	brew install automake
	brew install cmake
	brew install openssl
	brew install pkg-conf
	cp /opt/homebrew/bin/glibtoolize /opt/homebrew/bin/libtoolize
	exit 0
elif [ "$1" == "--installdeps" ]; then
	sudo yum -y install libpcap-devel
	sudo yum -y install zlib-devel
	sudo yum -y install ncurses-static
	sudo yum -y install ncurses-devel
	sudo yum -y install libzen-devel
	sudo yum -y install librdkafka-devel
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
elif [ "$1" == "v1.22.1" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=v1.22.1
	LIBLTNTSTOOLS_TAG=dc01e18312b1b716f3d5716b63af49137080f380
	LIBKLSCTE35_TAG=82dbcd1d540ed44ed1e421d708c8e2b1e5b64aa8
	LIBKLVANC_TAG=vid.obe.1.6.0
elif [ "$1" == "v1.23.0" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=v1.23.0
	LIBLTNTSTOOLS_TAG=21bdf238d777d53039d05baebff5f854a9f9da3b
	LIBKLSCTE35_TAG=82dbcd1d540ed44ed1e421d708c8e2b1e5b64aa8
	LIBKLVANC_TAG=vid.obe.1.6.0
elif [ "$1" == "v1.24.0" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=v1.24.0
	LIBLTNTSTOOLS_TAG=2a7bbb009b6d859c84d424499fe6297339f7d6e3
	LIBKLSCTE35_TAG=82dbcd1d540ed44ed1e421d708c8e2b1e5b64aa8
	LIBKLVANC_TAG=vid.obe.1.6.0
elif [ "$1" == "v1.25.0" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=v1.25.0
	LIBLTNTSTOOLS_TAG=2dd9055be11b8b4549a06802b9adf73a556cd574
	LIBKLSCTE35_TAG=82dbcd1d540ed44ed1e421d708c8e2b1e5b64aa8
	LIBKLVANC_TAG=vid.obe.1.6.0
elif [ "$1" == "v1.26.1" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=v1.26.1
	LIBLTNTSTOOLS_TAG=942331fd360cc63bfe66c96a0727509bdb38df58
	LIBKLSCTE35_TAG=82dbcd1d540ed44ed1e421d708c8e2b1e5b64aa8
	LIBKLVANC_TAG=vid.obe.1.6.0
elif [ "$1" == "v1.27.0a" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=be901547c7f676849db96b04dfbced5809b81c34
	LIBLTNTSTOOLS_TAG=a484628105029ce7881f6bae3aa1927be6f8f02f
	LIBKLSCTE35_TAG=82dbcd1d540ed44ed1e421d708c8e2b1e5b64aa8
	LIBKLVANC_TAG=vid.obe.1.6.0
elif [ "$1" == "v1.28.0" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=576cf78c09ec5f92f3afee3b7dcb23d82e2394b4
	LIBLTNTSTOOLS_TAG=cc78a640fdcaec061fd72b6fb6c211e979bae542
	LIBKLSCTE35_TAG=82dbcd1d540ed44ed1e421d708c8e2b1e5b64aa8
	LIBKLVANC_TAG=vid.obe.1.6.0
elif [ "$1" == "v1.29.0" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=576cf78c09ec5f92f3afee3b7dcb23d82e2394b4
	LIBLTNTSTOOLS_TAG=bad6c2b09ea4523380615a44ac550bce8ee9e86a
	LIBKLSCTE35_TAG=82dbcd1d540ed44ed1e421d708c8e2b1e5b64aa8
	LIBKLVANC_TAG=vid.obe.1.6.0
elif [ "$1" == "v1.30.0" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=v1.30.0
	LIBLTNTSTOOLS_TAG=4252c52d67ad7d73d14988d0ea3bd72a362cddd2
	LIBKLSCTE35_TAG=82dbcd1d540ed44ed1e421d708c8e2b1e5b64aa8
	LIBKLVANC_TAG=vid.obe.1.6.0
elif [ "$1" == "v1.31.1" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=v1.31.1
	LIBLTNTSTOOLS_TAG=afea546a286f6ad360210ec1516c3a25f0efcd3a
	LIBKLSCTE35_TAG=82dbcd1d540ed44ed1e421d708c8e2b1e5b64aa8
	LIBKLVANC_TAG=vid.obe.1.6.0
elif [ "$1" == "v1.32.1" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=v1.32.1
	LIBLTNTSTOOLS_TAG=e5b167a9ca9dff76b05b2f57220b254d24f0019e
	LIBKLSCTE35_TAG=82dbcd1d540ed44ed1e421d708c8e2b1e5b64aa8
	LIBKLVANC_TAG=vid.obe.1.6.0
elif [ "$1" == "v1.33.1" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=v1.33.1
	LIBLTNTSTOOLS_TAG=a23f5215df4fc1831ef267aadf1ac71db7f99277
	LIBKLSCTE35_TAG=82dbcd1d540ed44ed1e421d708c8e2b1e5b64aa8
	LIBKLVANC_TAG=vid.obe.1.6.0
elif [ "$1" == "v1.34.1" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=v1.34.1
	LIBLTNTSTOOLS_TAG=761080185e8213be4c134b91831823b1049263a0
	LIBKLSCTE35_TAG=348bdd7432ce9d65cbd28c3578a03fa23df9fea1
	LIBKLVANC_TAG=vid.obe.1.6.0
elif [ "$1" == "v1.35.1-dev" ]; then
	DEP_BITSTREAM_TAG=20ce4345061499abc0389e9cd837665a62ad6add
	DEP_LIBDVBPSI_TAG=d2a81c20a7704676048111b4f7ab24b95a904008
	DEP_FFMPEG_TAG=release/4.4
	LTNTSTOOLS_TAG=master
	LIBLTNTSTOOLS_TAG=pechanges-1
	LIBKLSCTE35_TAG=348bdd7432ce9d65cbd28c3578a03fa23df9fea1
	LIBKLVANC_TAG=vid.obe.1.6.0
else
	echo "Invalid argument"
	exit 1
fi

if [ "`uname -o`" == "Darwin" ]; then
	BUILD_LIBOPENSSL=1
	JOBS=16
	DEP_BITSTREAM_TAG=fc71ca6d9da88e82ada96588ebf2e121cd3ad583
	BUILD_NTT=0
	BUILD_LIBRDKAFKA=1
fi

if [ $BUILD_LIBRDKAFKA -eq 1 ]; then
        if [ ! -d librdkafka ]; then
		git clone https://github.com/confluentinc/librdkafka.git
		cd librdkafka && git checkout $LIBRDKAFKA_TAG && cd ..
	fi

fi

if [ $BUILD_LIBOPENSSL -eq 1 ]; then
        if [ ! -d openssl ]; then
		git clone https://github.com/openssl/openssl.git
		cd openssl && git checkout $LIBOPENSSL_TAG && cd ..
	fi

fi

if [ $BUILD_JSONC -eq 1 ]; then
        if [ ! -d json-c ]; then
                git clone https://github.com/json-c/json-c.git
                cd json-c && git checkout $LIBJSONC_TAG && cd ..
        fi
fi

if [ ! -d libzvbi ]; then
        git clone https://github.com/LTNGlobal-opensource/libzvbi.git
        if [ "$LIBZVBI_TAG" != "" ]; then
                cd libzvbi
                git checkout $LIBZVBI_TAG
                patch -p1 <../0000-libzvbi-remove-png-dep.patch
                cd ..
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
	cd srt && git checkout v1.4.4 -b build
	patch -p1 <../0002-srt-cmake.patch
	cd ..
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
		cd ffmpeg
		git checkout $DEP_FFMPEG_TAG
		patch -p1 <../0001-ffmpeg.patch
		cd ..
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

if [ $BUILD_NTT -eq 1 ]; then
	if [ ! -d libntt ]; then
		git clone git@git.ltnglobal.com:video/libntt.git
		if [ "$LIBNTT_TAG" != "" ]; then
			cd libntt && git checkout $LIBNTT_TAG && cd ..
		fi
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

if [ $BUILD_LIBOPENSSL -eq 1 ]; then
        pushd openssl
                if [ ! -f .skip ]; then
			./Configure --prefix=$PWD/../target-root/usr no-shared no-docs
                        make -j$JOBS
                        make install
                        touch .skip
		fi
        popd
fi

if [ $BUILD_LIBRDKAFKA -eq 1 ]; then
        pushd librdkafka
		if [ ! -f .skip ]; then
			./configure --prefix=$PWD/../target-root/usr --disable-shared
			make -j$JOBS
			make install
			touch .skip
		fi
        popd
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

pushd libzvbi
  if [ ! -f .skip ]; then
	./configure --prefix=$PWD/../target-root/usr --enable-shared=no
	make -j$JOBS
	make install
	touch .skip
  fi
popd

pushd srt
  if [ ! -f .skip ]; then
	./configure --enable-static=ON --enable-shared=OFF --prefix=$PWD/../target-root/usr
	make -j8
	make install
	touch .skip
  fi
popd

pushd MediaInfoLib/Project/GNU/Library
  if [ ! -f .skip ]; then
	./autogen.sh
	./configure --enable-shared=no --enable-static=yes --prefix=$PWD/../../../../target-root/usr
	make -j$JOBS
	make install
	touch .skip
  fi
popd

pushd bitstream
	make PREFIX=$PWD/../target-root/usr
	make PREFIX=$PWD/../target-root/usr install
popd

pushd libdvbpsi
  if [ ! -f .skip ]; then
	export CFLAGS="-I$PWD/../target-root/usr/include"
	export LDFLAGS="-L$PWD/../target-root/usr/lib"
	./bootstrap
	./configure --prefix=$PWD/../target-root/usr --enable-shared=no
	make -j$JOBS
	make install
	touch .skip
  fi
popd

pushd libklvanc
  if [ ! -f .skip ]; then
	export CFLAGS="-I$PWD/../target-root/usr/include"
	export LDFLAGS="-L$PWD/../target-root/usr/lib"
	./autogen.sh --build
	./configure --prefix=$PWD/../target-root/usr --enable-shared=no
	make -j$JOBS
	make install
	touch .skip
  fi
popd

pushd libklscte35
  if [ ! -f .skip ]; then
	export CFLAGS="-I$PWD/../target-root/usr/include"
	export LDFLAGS="-L$PWD/../target-root/usr/lib"
	./autogen.sh --build
	./configure --prefix=$PWD/../target-root/usr --enable-shared=no
	make -j$JOBS
	make install
	touch .skip
  fi
popd

if [ $BUILD_NTT -eq 1 ]; then
	ENABLE_NTT=yes
	pushd libntt
		./autogen.sh --build
		./configure --prefix=$PWD/../target-root/usr
		make -j$JOBS
		make install
	popd
else
	ENABLE_NTT=no
fi

pushd ffmpeg
  if [ ! -f .skip ]; then
	export CFLAGS="-I$PWD/../target-root/usr/include"
	export LDFLAGS="-L$PWD/../target-root/usr/lib -L$PWD/../target-root/usr/lib64 -lcrypto -lm -lsrt"
	export PKG_CONFIG_PATH="$PWD/../target-root/usr/lib64/pkgconfig"
	./configure --prefix=$PWD/../target-root/usr --disable-iconv --enable-static \
		--disable-audiotoolbox --disable-videotoolbox --disable-avfoundation \
		--disable-vaapi --disable-vdpau \
		--enable-libsrt --pkg-config-flags="--static"
	# run this again for macos
	make -j$JOBS
	make install
	touch .skip
  fi
popd

pushd libltntstools
	export CFLAGS="-I$PWD/../target-root/usr/include $NIELSEN_INC"
	export CPPFLAGS="-I$PWD/../target-root/usr/include $NIELSEN_INC"
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
	./configure --prefix=$PWD/../target-root/usr --enable-shared=no --enable-ntt=$ENABLE_NTT
	make -j$JOBS
	make install
popd

