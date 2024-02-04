#!/bin/bash

# handle script args
function Help {
  echo "Usage: ./upgrade_linux_on_ubuntu.sh <VERSION> Example: ./install_linux_kernel.sh v5.15.147"
}

if [ $# -eq 0 ]; then
  Help
  exit
fi

while getopts ":h" option; do
   case $option in
      h) Help && exit;;
     \?) echo "Error: Invalid option" && exit;;
   esac
done

# do work
debs_url=https://kernel.ubuntu.com/mainline/$1/amd64/  # url of page with links to kernels .deb packages

# command below parses debs_url page and downloads kernel deb packages 
curl $debs_url | \
  grep -io '<a href=['"'"'"][^"'"'"']*['"'"'"]' | \
  sed -e 's/^<a href=["'"'"']//i' -e 's/["'"'"']$//i' | \
  grep deb | xargs -I _ curl --remote-name "$debs_url"_
                                                                                                                                                 
sudo apt install -y ./*.deb
