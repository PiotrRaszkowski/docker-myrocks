FROM ubuntu:16.04

USER root

RUN apt-get update
RUN apt-get install -y g++ cmake libbz2-dev libaio-dev bison \
zlib1g-dev libsnappy-dev libgflags-dev libreadline6-dev libncurses5-dev \
libssl-dev liblz4-dev libboost-dev gdb git

RUN git clone --progress https://github.com/facebook/mysql-5.6.git
WORKDIR /mysql-5.6
RUN git submodule init
RUN git submodule update
#RUN export WITH_LZ4=/usr
#RUN export WITH SNAPPY=/usr/lib/x86_64-linux-gnu
#RUN export WITH_ZSTD=system
RUN apt-get install -y zstd libzstd-dev
RUN cmake . -DCMAKE_BUILD_TYPE=RelWithDebInfo -DWITH_SSL=system \
-DWITH_ZLIB=bundled -DMYSQL_MAINTAINER_MODE=0 -DENABLED_LOCAL_INFILE=1 \
-DENABLE_DTRACE=0 -DCMAKE_CXX_FLAGS="-march=native" -DWITH_LZ4=/usr/lib/x86_64-linux-gnu -DWITH_SNAPPY=/usr
RUN make -j8
