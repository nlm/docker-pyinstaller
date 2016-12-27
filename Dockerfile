FROM debian:jessie
MAINTAINER Nicolas Limage <github@xephon.org>

ARG PYTHON_VERSION=3.4
ENV PYTHON_VERSION $PYTHON_VERSION
ENV PYTHON python$PYTHON_VERSION

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update && apt-get -y install \
    $PYTHON \
    $PYTHON-dev \
    upx-ucl \
    binutils \
    && rm -rf /var/lib/apt/lists/*

COPY get-pip.py /usr/local/bin/
RUN $PYTHON /usr/local/bin/get-pip.py

ARG PYINSTALLER_VERSION=3.1.1
ENV PYINSTALLER_VERSION $PYINSTALLER_VERSION
RUN $PYTHON -m pip install pyinstaller==$PYINSTALLER_VERSION

VOLUME /data
WORKDIR /data

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
