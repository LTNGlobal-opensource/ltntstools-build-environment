# docker run -it --rm --net=host ubuntu:20.04

FROM docker.io/ubuntu:20.04

RUN mkdir /src
RUN echo '#!/bin/bash' >>/src/build.sh
RUN echo "git clone https://github.com/LTNGlobal-opensource/ltntstools-build-environment" >>/src/build.sh
RUN echo "cd ltntstools-build-environment" >>/src/build.sh
RUN echo "./build.sh" >>/src/build.sh
RUN chmod 755 /src/build.sh

RUN apt update -y
RUN apt install -y build-essential git tcpdump wget netcat vim screen procps automake libtool
RUN echo "startup_message off" >/root/.screenrc

# Application specific
RUN apt install -y libz-dev libncurses-dev libpcap-dev nasm liblzma-dev libbz2-dev

# I don't want a dynamic link to pcap in the final binary
RUN rm /usr/lib/x86_64-linux-gnu/libpcap.so

WORKDIR /src

ENV SHELL /bin/bash

CMD [ "/bin/bash" ]
