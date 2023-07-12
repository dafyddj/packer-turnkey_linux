#!/bin/bash -eux

if [[ $PACKER_BUILDER_TYPE =~ virtualbox ]]; then
    echo "==> Installing VirtualBox guest additions"
    apt-get update
    apt-get install -y linux-headers-$(uname -r) build-essential perl
    apt-get install -y dkms

    mount -o loop VBoxGuestAdditions.iso /mnt
    sh /mnt/VBoxLinuxAdditions.run --nox11
    umount /mnt
    rm VBoxGuestAdditions.iso
fi
