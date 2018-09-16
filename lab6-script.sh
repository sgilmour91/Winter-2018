#!/bin/sh -e
umask 022

#This script takes partitions on separate drives and creates filesystems for
#each partition, mounts the partitions after creating the mount points, creates
#directories and folders in some of the partitions, and lists any arguments used
#as well as the contents of each partition.

#Print the date and who is running the script as well as the script owner's information.
#
echo "Date and Time: $(date)"
echo
echo "Name: Scott Gilmour"
echo
echo "College username: gilm0091"
echo
echo "Script run by: $(whoami)"
echo

#Silently unmounts any specified partitions and formats each partition with a 
#file system using an implicit loop.
#
echo "a. Creating filesystems on each partition:"
echo "---------------------------------------"
echo

if grep "^/dev/sd.1" /proc/mounts > /dev/null ; then
        for hdd do
                umount -f $hdd 2>/dev/null
        done
fi

for part do
        if [ $part = "/dev/sde1" ] ; then
                echo "Making an xfs filesystem on $1:"
                mkfs -t xfs -f -q $1
        elif [ $part = "/dev/sdf1" ] ; then
                echo "Making an ext3 filesystem on $2:"
                mkfs -q -F -t ext3 $2
        elif [ $part = "/dev/sdg1" ] ; then
                echo "Making an ext4 filesystem on $3:"
                mkfs -q -F -t ext4 $3
        elif [ $part = "/dev/sdh1" ] ; then
                echo "Making an ext3 filesystem on $4:"
                mkfs -q -F -t ext3 $4
        fi
done
echo

#Make the mounting directories for each partition and mount each partition using
#an explicit loop.
#
echo "b. Creating mount points and mount partitions:"
echo "-------------------------------------------"
echo
for fs in /dev/sde1 /dev/sdf1 /dev/sdg1 /dev/sdh1 ; do
        if [ ! -e "/mnt/sde1" ] ; then
                mkdir /mnt/sde1
        elif [ ! -e "/mnt/sdf1" ] ; then
                mkdir /mnt/sdf1
        elif [ ! -e "/mnt/sdg1" ] ; then
                mkdir /mnt/sdg1
        elif [ ! -e "/mnt/sdh1" ] ; then
                mkdir /mnt/sdh1
        elif ! grep -qs "sde1" /proc/mounts ; then
                mount $1 /mnt/sde1
                echo "$1 was mounted on /mnt/sde1"
        elif ! grep -qs "sdf1" /proc/mounts ; then
                mount $2 /mnt/sdf1
                echo "$2 was mounted on /mnt/sdf1"
        elif ! grep -qs "sdg1" /proc/mounts ; then
                mount $3 /mnt/sdg1
                echo "$3 was mounted on /mnt/sdg1"
        elif ! grep -qs "sdh1" /proc/mounts ; then
                mount $4 /mnt/sdh1
                echo "$4 was mounted on /mnt/sdh1"
        fi
done
echo

#Using an integer expression inside of a loop, make directories in some of the 
#partitions.
#
echo "c. Creating directories:"
echo "-------------------------------"
echo

i=1
while [ $i -le 4 ] ; do
        if [ $i -eq 1 ] ; then
                echo "Making directory Lab6part1 in /mnt/sde1"
                mkdir -p /mnt/sde1/Lab6Part1
                i=$(( i + 1))
        elif [ $i -eq 2 ] ; then
                echo "Making directory Lab6/Part2 in /mnt/sdf1"
                mkdir -p /mnt/sdf1/Lab6/Part2
                i=$(( i + 1))
        elif [ $i -eq 3 ] ; then
                echo "Making directory Part3 in /mnt/sdg1"
                mkdir -p /mnt/sdg1/Part3
                i=$(( i + 1))
        i=$(( i + 1))
        fi
done
echo

#List the implicit arguments used in the script using a loop.
#
echo "d. List of the arguments used:"
echo "------------------------------"
echo

for args do
        if [ $args = "/dev/sde1" ] ; then
                echo "The first argument is $1"
        elif [ $args = "/dev/sdf1" ] ; then
                echo "The second argument is $2"
        elif [ $args = "/dev/sdg1" ] ; then
                echo "The third argument is $3"
        elif [ $args = "/dev/sdh1" ] ; then
                echo "The fourth argument is $4"
                break
        fi
done
echo

#Recursively list the contents of each mounted partition with an integer
#expression loop.
#
echo "e. Listed contents of the partitions:"
echo "-------------------------------------"
echo

cont="Contents of /dev/sd"
while [ $# -ge 1 ] ; do
        case $1 in
                "/dev/sde1" ) echo "$cont""e1:"
                              echo
                           find /mnt/sde1
                             shift ;;
                "/dev/sdf1" ) echo "$cont""f1:" 
                              echo
                           find /mnt/sdf1
                             shift ;;
                "/dev/sdg1" ) echo "$cont""g1:"
                              echo
                           find /mnt/sdg1
                             shift ;;
                "/dev/sdh1" ) echo "$cont""h1:"
                              echo
                           find /mnt/sdh1
                             shift ;;
        esac
echo
done

                                                                                                                                                                    