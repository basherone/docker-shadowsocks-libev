FROM ubuntu:latest

MAINTAINER basherone <basherone123@gmail.com>

ENV DEPENDENCIES git-core build-essential autoconf libtool libssl-dev asciidoc
ENV BASEDIR /tmp/shadowsocks-libev
ENV VERSION v2.4.8

# Set up building environment
RUN apt-get update \
 && apt-get install -y $DEPENDENCIES

# Get the latest code, build and install
RUN git clone https://github.com/shadowsocks/shadowsocks-libev.git $BASEDIR
WORKDIR $BASEDIR
RUN git checkout $VERSION \
 && ./configure \
 && make \
 && make install

# Tear down building environment and delete git repository
WORKDIR /
RUN rm -rf $BASEDIR/shadowsocks-libev\
 && apt-get --purge autoremove -y $DEPENDENCIES\
 && apt-get clean

ENTRYPOINT ["/usr/local/bin/ss-server"]
