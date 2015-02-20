FROM pataquets/ubuntu:trusty

ENV OSTIARY_VERSION 4.0
ENV OSTIARY_TAR ostiary-$OSTIARY_VERSION.tar.gz

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get -y install \
      build-essential \
      wget \
  && \
  wget http://ingles.homeunix.net/software/ost/latest/${OSTIARY_TAR} && \
  tar xvf ${OSTIARY_TAR} && \
  rm -v ${OSTIARY_TAR} && \
  cd ostiary-${OSTIARY_VERSION} && \
  ./configure && \
  make all && \
  make install && \
  cd .. && \
  rm -vrf ostiary-${OSTIARY_VERSION} \
  && \
  apt-get purge -y --auto-remove \
    binutils \
    build-essential \
    make \
    wget \
    xz-utils \
  && \
  apt-get autoremove -y --purge && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
