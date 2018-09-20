#!/bin/bash
set -e
#### Validate input ####
if [[ ! -f "/mnt/user/domains/$1/vdisk1.img" ]]; then
  echo "Error: File /mnt/user/domains/$1/vdisk1.img not found." >&2
  echo "Usage: docker run ... Cloud 10 to customize the Cloud/vdisk1.img file and resize it to 10GBs." >&2
  exit 1
fi

if [[ -z "$2" ]]; then
  size="10"
else
  size="$2"
fi

if [[ ! "$2" || "$2" = *[^0-9]* ]]; then
    echo "Error: '$2' is not a number. The disk will be resized to the specified number of GBs." >&2
    echo "Usage: docker run ... Cloud 10 to customize the Cloud/vdisk1.img file and resize it to 10GBs." >&2
    exit 1
fi

qemu-img resize "/mnt/user/domains/$1/vdisk1.img" "$size"G
virt-customize -a "/mnt/user/domains/$1/vdisk1.img" --uninstall cloud-init --ssh-inject root:file:/root/root.pubkey --hostname "$1"
