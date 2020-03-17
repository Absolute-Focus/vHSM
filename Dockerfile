FROM alpine:latest

ENV SOFTHSM2_SOURCES=/opt/SoftHSMv2

# install build dependencies
RUN apk --update add nodejs-current 
RUN apk add npm
RUN apk add autoconf
RUN apk add automake
RUN apk add libtool
RUN apk add openssl-dev
RUN apk add sqlite
RUN apk add sqlite-dev
RUN apk add alpine-sdk
RUN apk add python

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

# Node StuffRUN add 
COPY package.json .
COPY package-lock.json .
COPY tsconfig.json .
RUN npm install -g typescript
RUN npm install
COPY src .
RUN tsc

CMD ["npm", "run", "start-server"]