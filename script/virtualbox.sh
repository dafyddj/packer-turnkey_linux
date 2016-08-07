#!/bin/bash -eux

if [[ $PACKER_BUILDER_TYPE =~ virtualbox ]]; then
    echo "==> Installing VirtualBox guest additions"
    apt-get install -y linux-headers-$(uname -r) build-essential dkms

    VBOX_VERSION=$(cat .vbox_version)
    mount -o loop,ro VBoxGuestAdditions_${VBOX_VERSION}.iso /mnt
    sh /mnt/VBoxLinuxAdditions.run --nox11
    umount /mnt
    rm VBoxGuestAdditions_${VBOX_VERSION}.iso
    rm .vbox_version

    if [[ $VBOX_VERSION = "4.3.10" ]]; then
        ln -s /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions
    fi
fi
