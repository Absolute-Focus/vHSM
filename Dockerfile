FROM alpine:latest

ENV SOFTHSM2_SOURCES=/opt/SoftHSMv2

# install build dependencies
RUN apk --update add \
        alpine-sdk \
        autoconf \
        automake \
        libtool \
        openssl-dev

# build and install SoftHSM2
COPY SoftHSMv2 /opt/SoftHSMv2
WORKDIR ${SOFTHSM2_SOURCES}

RUN sh autogen.sh \
    && ./configure --prefix=/usr/local \
    && make \
    && make install

WORKDIR /root
RUN rm -fr ${SOFTHSM2_SOURCES}

# install pkcs11-tool
RUN apk --update add opensc