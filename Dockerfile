FROM ubuntu:16.04 AS builder
LABEL maintainer "mecab <mecab@misosi.ru>"

RUN apt-get -y update && \
    apt-get -y install software-properties-common && \
    add-apt-repository -y ppa:bitcoin/bitcoin && \
    apt-get -y update && \
    apt-get -y install curl libssl-dev libevent-dev libboost-all-dev libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev libprotobuf-dev libqrencode-dev libzmq5 libdb4.8++ libminiupnpc10 && \
    cd /usr/local/bin && \
    curl -L -O https://github.com/wavidev-the-man/wavi/releases/download/v0.12.2.3/wavicore-0.12.2.3-ubuntu64.tar.gz && \
    echo '4da0105c0c7502cbacf811555cf18c56b6328b03b96d742e7f7cb7cca223d50f  wavicore-0.12.2.3-ubuntu64.tar.gz' | sha256sum -c && \
    tar -zxvf wavicore-0.12.2.3-ubuntu64.tar.gz && \
    # Cleaning up
    rm wavicore-0.12.2.3-ubuntu64.tar.gz && \
    apt-get -y purge software-properties-common && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/local/bin/wavid"]
VOLUME ["/data"]
CMD ["-datadir=/data"]
EXPOSE 9983 9984

