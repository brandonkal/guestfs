#!/bin/bash
set -e
#### Validate input ####
if [[ -f /mnt/domains/"$1"/vdisk1.img ]]; then
  echo "Error: File not found." >&2
  echo "Usage: docker run ... Cloud 10 to customize the Cloud/vdisk1.img file and resize it to 10GBs." >&2
  exit 1
fi

if [[ ! "$2" || "$2" = *[^0-9]* ]]; then
    echo "Error: '$2' is not a number. The disk will be resized to the specified number of GBs." >&2
    echo "Usage: docker run ... Cloud 10 to customize the Cloud/vdisk1.img file and resize it to 10GBs." >&2
    exit 1
fi

qemu-img resize /mnt/domains/"$1"/disk1.img "$2"G
virt-customize -a /mnt/domains/"$1"/vdisk1.img --uninstall cloud-init --ssh-inject root:file:/root/root.pubkey --hostname "$1"
