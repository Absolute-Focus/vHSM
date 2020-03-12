FROM alpine:latest

ENV SOFTHSM2_SOURCES=/opt/SoftHSMv2

# install build dependencies
RUN apk --update add \
        alpine-sdk \
        autoconf \
        automake \
        libtool \
        openssl-dev \
        sqlite \
        sqlite-dev 

# build and install SoftHSM2
COPY SoftHSMv2 /opt/SoftHSMv2
WORKDIR ${SOFTHSM2_SOURCES}

RUN sh autogen.sh \
    && ./configure --with-objectstore-backend-db --with-crypto-backend=openssl \
    && make \
    && make install

WORKDIR /root
RUN rm -fr ${SOFTHSM2_SOURCES}

# install pkcs11-tool
RUN apk --update add opensc