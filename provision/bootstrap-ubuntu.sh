#!/bin/bash

apt-get update && sudo apt-get upgrade
apt-get install -y python
apt-get install -y default-jre
echo "cloud init completed"
