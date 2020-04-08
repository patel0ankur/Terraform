#!/bin/bash
yum install update -y 
sudo /usr/sbin/useradd -c "Admin User" -d /home/admin -g root admin
yum install nginx -y 
yum -y install chrony
systemctl enable chronyd
systemctl start chronyd

mkfs -t ext4 /dev/xvdb
mkdir /mnt/disk_b
mount /dev/xvdb /mnt/disk_b
echo '/dev/xvdb /mnt/disk_b ext4 defaults,nofail,noatime  0  0' >> /etc/fstab


