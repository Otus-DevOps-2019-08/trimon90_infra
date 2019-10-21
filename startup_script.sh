#!/usr/bin/env bash

# install ruby & libs

sudo apt update 
sudo apt install -y ruby-full 
sudo apt install -y ruby-bundler
sudo apt install -y ruby-dev 
sudo apt install -y build-essential
sudo apt -y install libgmp-dev

# install moongodb & start it
wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
sudo apt update
sudo apt install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

# deploy app & start puma server

cd ~
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
