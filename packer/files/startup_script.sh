#!/usr/bin/env bash

# deploy app & start puma server

cd /home/appuser
git clone -b monolith https://github.com/express42/reddit.git
cd reddit 
bundle install


# add systemd unit

cp ~/reddit.service /etc/systemd/system

systemctl daemon-reload
systemctl start reddit
systemctl enable reddit
