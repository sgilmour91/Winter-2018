#!/bin/sh -u
umask 022

echo "Date and Time: $(date)"
echo "Name: Scott Gilmour"
echo "College username: gilm0091"
echo "Script run by: $(whoami) "

echo
echo "a. Unmounting the $1 hard drive partition"
echo "--------------------------"
echo
umount $1

echo
echo "b. Converting the $1 partition into a physical volume"
echo "---------------------------------------------------------"
echo
pvcreate $1

echo
echo "c. List of all physical volumes"
echo "-------------------------------"
echo
pvs

echo
echo "d. Adding the $1 physical volume to the cl00 volume group"
echo "-------------------------------------------------------------"
echo
vgextend /dev/cl00 $1

echo
echo "e. List of all volume groups:"
echo "-----------------------------"
echo
vgs

echo
echo "f. Removing the $1 physical volume from the cl00 volume group"
echo "------------------------------------------------------------"
echo
vgreduce /dev/cl00 /dev/sde1

echo
echo "g. List of all physical volumes:"
echo "--------------------------------"
echo
pvs

echo
echo "h. Formating the /dev/sdf1 partition with an ext4 filesystem"
echo "-------------------------------------------------------"
echo
mkfs -t ext4 /dev/sdf1

echo
echo "i. The type of filesystem on /dev/sdf1 is:"
echo "------------------------------------------"
echo
file -s /dev/sdf1

echo
echo "j. The current kernel version is:"
echo "-------------------------"
echo
uname -r

echo
echo "k. The current status of all RAID arrays is:"
echo "--------------------------------------------"
echo
echo "RAID Status"
mdadm --detail /dev/md125 /dev/md126 /dev/md127 | grep -e 'State :' -e 'md12.*'
