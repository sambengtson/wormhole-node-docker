FROM ubuntu:16.04

MAINTAINER Sam Bengtson <sam.bengtson@gmail.com>

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y build-essential libtool autotools-dev automake pkg-config git libssl-dev libevent-dev bsdmainutils libminiupnpc-dev libzmq3-dev libboost-all-dev libdb++-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev

ADD .bitcoin /.bitcoin

 RUN git clone https://github.com/copernet/wormhole.git

 WORKDIR /wormhole/share
 RUN ./genbuild.sh ../src/obj/build.h

 WORKDIR /wormhole
 RUN ./autogen.sh
 RUN ./configure
 RUN make
 RUN make install

WORKDIR /wormhole/src

CMD wormholed