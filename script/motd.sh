#!/bin/bash -eux

echo "==> Recording box generation date"
date > /etc/vagrant_box_build_date

echo "==> Customizing message of the day"
MOTD_FILE=/etc/update-motd.d/04-packer-build-info

cat << 'EOF' > ${MOTD_FILE}
#! /bin/sh

echo "  Box built on $(cat /etc/vagrant_box_build_date)"
echo
EOF

chmod +x ${MOTD_FILE}
