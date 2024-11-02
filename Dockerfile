FROM ubuntu:24.04

MAINTAINER theoj-cerebras (https://github.com/theoj-cerebras)

RUN apt-get update -y && \
    apt-get install -y iproute2 net-tools tcpreplay && \
    apt-get clean -qy

COPY ./replay-sflow-pcap.sh /

SHELL ["/bin/bash","-c"]
ENTRYPOINT ["/replay-sflow-pcap.sh"]
