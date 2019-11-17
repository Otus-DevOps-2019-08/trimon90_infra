#!/bin/bash

# create VM instance
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family reddit-full \
  --machine-type=f1-micro \
  --tags puma-server \
  --restart-on-failure \
  --network-tier STANDARD

# create firewall rule
gcloud compute firewall-rules create default-puma-server \
	--action allow \
	--direction ingress \
	--rules tcp:9292 \
	--source-ranges 0.0.0.0/0 \
	--target-tags puma-server


