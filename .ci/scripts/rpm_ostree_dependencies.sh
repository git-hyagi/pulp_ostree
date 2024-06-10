#!/bin/bash

# Script to install packages used in rpm-ostree import-commit tests.

set -ev

dnf -y install rpm-ostree-2024.6-1.el9 selinux-policy

pushd /tmp
wget https://dl.fedoraproject.org/pub/fedora/linux/releases/40/Everything/x86_64/os/Packages/f/fedora-gpg-keys-40-1.noarch.rpm
rpm2cpio fedora-gpg-keys-40-1.noarch.rpm| cpio -idmv
cp etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-40-x86_64 /etc/pki/rpm-gpg/
popd