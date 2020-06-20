FROM centos:7.6.1810 AS build

LABEL maintainer="benedict.endemann@ltnglobal.com"

WORKDIR /tmp/

ARG TOOL_VERSION=v1.5.0

COPY build.sh build.sh

RUN yum -y install \
    git \
    make \
    gcc \
    automake \
    libtool \
    nasm \
    libpcap-devel \
    zlib-devel \
    ncurses-devel \
    rpmdevtools \
    rpmlint \
    which \
&& ./build.sh ${TOOL_VERSION} \
&& cd ltntstools/rpm \
&& ./make-rpm.sh



FROM centos:7.6.1810

LABEL maintainer="benedict.endemann@ltnglobal.com"

COPY --from=build /tmp/ltntstools/rpm/ltntstools-*.rpm /tmp/

COPY Dockerfile /Dockerfile

RUN yum -y install \
    /tmp/ltntstools-*.rpm \
&& rm /tmp/ltntstools-*.rpm

CMD find /usr/local/bin/ -name tstools_* -printf '%f\n'
