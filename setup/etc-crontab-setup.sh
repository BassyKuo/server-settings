#!/bin/bash

# [root]
#echo "[root] Copy files to /etc/cron.daily ..."
#sudo cp ../rc/cron.daily/* /etc/cron.daily/
#echo "[root] Copy files to /etc/cron.weekly ..."
#sudo cp ../rc/cron.weekly/* /etc/cron.weekly/
echo "[root] Copy files to /etc/cron.hourly ..."
sudo cp ../rc/cron.hourly/* /etc/cron.hourly/
