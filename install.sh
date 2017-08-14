#!/bin/bash

###Dependencies

export DEBIAN_FRONTEND=noninteractive
if dpkg --get-selections | grep -q "^npm[[:space:]]*install$" >/dev/null; then
	echo -e "npm already installed"
else
	echo "must install npm"
	if sudo su -c "apt-get -qq install npm" root; then
		echo "successfully installed npm"
	else
		echo "error installing npm"
	fi
fi

echo "installing node.js"


url=https://github.com/nodejs/node

filename=$(basename "$url")

git clone "$url"
#tar -xvfz "$filename"

#dir=`tar -tvfz "$filename" | head -1 | cut -f1 -d"/"`

cd "$filename"

./configure
make -j4

#sudo su -c "mkdir -p /usr/bin/env" root
#sudo su -c "ln -s "$dir"/bin/node /usr/bin/env/node" root

install_dir="./node-red-install"

if [ -d "$install_dir" ] ; then
	echo "node-red install directory already exists!"
	exit 0
else
	mkdir node-red-install
fi

cd node-red-install

url=https://github.com/node-red/node-red/archive/0.17.5.tar.gz
nr_filnam=$(basename "$url")

wget "$url"

tar -xzvf "$nr_filnam"

dir=`tar -tzf "$nr_filnam" | head -1 | cut -f1 -d"/"`

cd "$dir"

npm install --production
