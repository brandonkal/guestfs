FROM ubuntu:18.04
MAINTAINER Brandon Kalinowski

WORKDIR /root

ENV DEBIAN_FRONTEND=noninteractive \
    LIBGUESTFS_BACKEND=direct

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
          libguestfs-tools \
          qemu-utils \
          linux-image-generic \       
          supermin \
     && rm -f /var/lib/apt/lists/*.*


ENTRYPOINT ["virt-customize"]
