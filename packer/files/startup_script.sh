#!/usr/bin/env bash

# deploy app & start puma server

cd /home/appuser
git clone -b monolith https://github.com/express42/reddit.git
ls -la
cd reddit 
bundle install

if [ $? -ne 0 ]; then
  echo "Failed to install with bundle"
  exit 1
fi

# add systemd unit

cp ~/reddit.service /etc/systemd/system

systemctl daemon-reload
systemctl start reddit
systemctl status reddit
