FROM debian:stable-slim
MAINTAINER Brandon Kalinowski

ENV DEBIAN_FRONTEND=noninteractive \
    LIBGUESTFS_BACKEND=direct

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        libguestfs-tools \
        qemu-utils \
        supermin && \
    apt-get install --no-install-recommends -y \
        linux-image-amd64 || echo "Failed to config image-amd64 but that is okay" \
    && rm -f /var/lib/apt/lists/*.*

WORKDIR /root
COPY docker-entrypoint.sh /
COPY 01-netcfg.yaml /
ENTRYPOINT ["/docker-entrypoint.sh"]
