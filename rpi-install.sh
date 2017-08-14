#!/bin/bash

##install dashboard/mongodb

npm install node-red-dashboard
npm install node-red-node-mongodb

mv flows/* ~/.node-red/lib/flows


echo "Creating ad-hoc network"
sudo su -c "cp /etc/network/interfaces /etc/network/interfaces-wifi"
sudo su -c "cp interface-adhoc /etc/network/interfaces"

sudo su -c "npm install -g pm2"

pm2 start /usr/bin/node-red --node-args="--max-old-space-size=128" -- -v
