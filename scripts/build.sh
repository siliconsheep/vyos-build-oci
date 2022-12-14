#!/usr/bin/env bash

mkdir -p /vyos/output

echo "###### 1. Creating VyOS ISO ######"
pushd build > /dev/null 2>&1
./configure \
  --architecture amd64 \
  --build-by "dieterbocklandt@gmail.com" \
  --build-type release \
  --version "${VYOS_VERSION_NO}"

sudo make iso

VYOS_ISO_PATH=$(find $(pwd)/build -maxdepth 1 -name 'vyos-*.iso')
echo "VyOS ISO build succeeded: ${VYOS_ISO_PATH}"
popd > /dev/null 2>&1

echo "###### 2. Setting up Ansible ######"
sudo pip3 install wheel
sudo pip3 install ansible

echo "###### 3. Running Ansible QEMU Playbook ######"

pushd vm-images > /dev/null 2>&1
ansible-playbook qemu.yml \
  -e cloud_init=true \
  -e cloud_init_ds=Oracle \
  -e parttable_type=mbr \
  -e grub_console=serial \
  -e guest_agent=qemu \
  -e enable_dhcp=true \
  -e enable_ssh=true \
  -e iso_local="${VYOS_ISO_PATH}" \
  -e vyos_version="${VYOS_VERSION_NO}" \
  -e keep_user=true \
  -e vyos_images_dir=/vyos/output
popd > /dev/null 2>&1