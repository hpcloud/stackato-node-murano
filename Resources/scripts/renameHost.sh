#!/bin/bash
# $1 - IP address of the node

# disable pw check so rename doesn't prompt for pw
touch /etc/sudoers.d/murano
chmod 0440 /etc/sudoers.d/murano
echo "stackato        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/murano

# wait for stackato to boot
sudo su -l stackato -c "/home/stackato/bin/kato process ready --block 1000 all" >> /tmp/setup.log 2>&1

# rename host to xip.io name
sudo su -l stackato -c "/home/stackato/bin/kato node rename $1.xip.io" >> /tmp/setup.log 2>&1

# re-enable pw check for safety
rm -f /etc/sudoers.d/murano
