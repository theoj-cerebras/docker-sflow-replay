# Replay sFlow PCAPs
You've captured some sFlow UDP packets in a pcap file (e.g., using tcpdump).
Now you want to replay them to a sFlow collector. This container/script replays
the sFlow pcap. It modifies the src/dst MAC and IP addresses, so that the
packets are valid and delivered to the collector.

## Build
Build the Docker image:
```bash
docker build -t sflow-replay .
```

## Usage
Run the container, mounting the pcap you want to replay, specifying the
destination address:
```bash
$ docker run -it --rm sflow-replay
Usage: /replay-sflow-pcap.sh <dest_address> <pcap_file> [extra args for tcpreplay-edit...]

$ docker run -it --rm -v PATH_TO_SFLOW.PCAP:/out.pcap sflow-replay COLLECTOR_ADDRESS /out.pcap -t
+ tcpreplay-edit --enet-smac=02:42:0a:f0:00:04 --enet-dmac=02:42:f4:6c:b0:7b --srcipmap=0.0.0.0/0:10.240.0.4 --dstipmap=0.0.0.0/0:123.4.5.6 --fixcsum -i eth0 -t /out.pcap
Actual: 287011 packets (361734846 bytes) sent in 3.70 seconds
Rated: 97520186.5 Bps, 780.16 Mbps, 77375.36 pps
Flows: 1 flows, 0.26 fps, 287011 unique flow packets, 0 unique non-flow packets
Statistics for network device: eth0
        Successful packets:        287011
        Failed packets:            0
        Truncated packets:         0
        Retried packets (ENOBUFS): 0
        Retried packets (EAGAIN):  0
```
