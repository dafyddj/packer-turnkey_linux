#!/usr/bin/env bash

set -eux

# Sample custom configuration script - add your own commands here
# to add some additional commands for your environment
#
# For example:
# yum install -y curl wget git tmux firefox xvfb

# Fixup network/interfaces which by default contains 2 eth interfaces
echo "==> Tidying up /etc/network/interfaces"
sed --in-place=.sed '10,$ d' /etc/network/interfaces
