#!/bin/sh

html=$(wget -qO- https://go.dev/dl/ | grep "linux-amd64")
file_name=$(echo "$html" | grep -oP 'href="\K[^"]+(?=")')

output=$(echo $file_name | grep -oP 'go[0-9\.]+')
echo $output >> /home/scripts/output.txt
version=$(awk -F" " '{print $1}' /home/scripts/output.txt)

cd /home/scripts
wget -q https://go.dev/dl/${version}linux-amd64.tar.gz
tar -xzf ${version}linux-amd64.tar.gz -C /usr/local