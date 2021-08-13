#!/bin/sh

set -ex

echo "[1] user: $(whoami)"

if [ `id -u` -ne 0 ]; then
  sudo $0
  exit 0
fi

echo "[2] user: $(whoami)"

DEBIAN_FRONTEND=noninteractive apt-get -y -qq -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" update
echo "update: $?"

DEBIAN_FRONTEND=noninteractive apt-get -y -qq -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
echo "upgrade: $?"

DEBIAN_FRONTEND=noninteractive apt-get -y -qq -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
echo "dist-upgrade: $?"

DEBIAN_FRONTEND=noninteractive apt-get -y -qq -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" autoremove
echo "autoremove: $?"
