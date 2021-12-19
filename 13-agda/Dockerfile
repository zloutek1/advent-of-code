FROM haskell:8

WORKDIR /data

RUN apt-get update \
  && apt-get install -y emacs wget vim \
  && rm -rf /var/lib/apt/lists/* \
  && cabal update \
  && cabal install alex happy \
  && wget -O agda-stdlib.tar https://github.com/agda/agda-stdlib/archive/v1.7.tar.gz \
  && tar -xzvf agda-stdlib.tar \
  && rm agda-stdlib.tar \
  && cd agda-stdlib-1.7 \
  && cabal install \
  && cabal install Agda \
  && cabal install

RUN mkdir /root/.agda
RUN echo standard-library > /root/.agda/libraries
RUN echo /data/agda-stdlib-1.7/standard-library.agda-lib > /root/.agda/defaults

ENTRYPOINT bash
