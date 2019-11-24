#!/bin/bash
set -e

APP_DIR=${1:-$HOME}

cd ~
git clone -b monolith https://github.com/express42/reddit.git reddit
cd reddit
bundle install

sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma

