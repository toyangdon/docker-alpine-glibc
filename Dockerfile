FROM alpine:3.9


ARG ARC_MODE=aarch64
ARG VER_GLIBC=2.29-r0
ARG GLIBC_DOWNLOAD_URL=https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${VER_GLIBC}

RUN apk upgrade --update-cache &&\
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub &&\
    wget ${GLIBC_DOWNLOAD_URL}/glibc-${VER_GLIBC}.apk &&\
    wget ${GLIBC_DOWNLOAD_URL}/glibc-bin-${VER_GLIBC}.apk &&\
    wget ${GLIBC_DOWNLOAD_URL}/glibc-i18n-${VER_GLIBC}.apk &&\
    apk  add glibc-${VER_GLIBC}.apk glibc-bin-${VER_GLIBC}.apk glibc-i18n-${VER_GLIBC}.apk &&\
    sleep 2 &&\
    /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8

ENV JAVA_HOME ${DIR_JAVA_HOME}
ENV PATH      $PATH:${DIR_JAVA_HOME}/bin
ENV LANG      en_US.UTF8
