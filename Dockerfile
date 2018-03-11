FROM resin/rpi-raspbian:jessie
RUN DEBIAN_FRONTEND=noninteractive \
    && cd /tmp/ \
    && curl -L https://github.com/sshmanko/acestream-armv7/archive/v3.1.24.tar.gz -o acestream_rpi.tar.gz \
    && tar xzfv acestream_rpi.tar.gz \
    && rm -rf acestream_rpi.tar.gz
RUN mv /tmp/acestream-* /tmp/acestream
RUN mkdir -p /system/etc \
    && mkdir -p /storage \
    && mv /tmp/acestream/androidfs/system/* /system/ \
    && find /system -type d -exec chmod 755 {} \; \
    && find /system -type f -exec chmod 644 {} \; \
    && mv /tmp/acestream/androidfs/acestream.engine/ / \
    && chmod 755 /system/bin/* /acestream.engine/python/bin/python \
    && rm -rf /tmp/* \
    && echo "67.215.246.10 router.bittorrent.com" >> /etc/hosts \
    && echo "87.98.162.88 dht.transmissionbt.com" >> /etc/hosts
EXPOSE 6878 62062
CMD ["/system/bin/acestream.sh"]
