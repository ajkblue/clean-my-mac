#!/bin/bash

#A free and simple script to clean and speed up your Mac.

#calculate used space
ifs=$(df -H / | egrep '/$' | awk '{print $4}' | cut -d "G" -f 1)
echo "Total free space before cleanup is "$ifs"GB"

#Saving for later...
#inspace=$(df -h | grep -A1 /dev/disk1 | sed -n 1p | awk '{ print $7 }')
#ins="${inspace:0:2}.${inspace:2:2}"
#echo "Total free space before cleanup is "$ins"GB and "$inspace"kb"
#UNIX maintenance scripts (not fully tested, may be added later)
#sudo periodic daily weekly monthly

#User Cache files
echo "Cleaning user Cache files from ~/Library/Caches"
rm -rf ~/Library/Caches/*
echo "Done cleaning from ~/Library/Caches"
#User Logs
echo "Cleaning user log file from ~/Library/logs"
rm -rf ~/Library/logs/*
echo "Done cleaning from ~/Library/logs"
#User Preference Log
echo "Cleaning user preference logs"
#rm -rf ~/Library/Preferences/*
echo "Done cleaning from /Library/Preferences"
#System Caches
echo "Cleaning system caches"
sudo rm -rf /Library/Caches/*
echo "Done cleaning system cache"
#System Logs
echo "Cleaning System Logs from /Library/logs"
sudo rm -rf /Library/logs/*
echo "Done cleaning from /Library/logs"
echo "Cleaning System Logs from /var/log"
sudo rm -rf /var/log/*
echo "Done cleaning from /var/log"
echo "Cleaning from /private/var/folders"
sudo rm -rf /private/var/folders/*
echo "Done cleaning from /private/var/folders"
#iOS Photo Caches, only run in OS X Mavericks and older
var=$(whoami)
ver=`sw_vers -productVersion | cut -d "." -f 2`
if (( $ver < 10 )); then
echo "Cleaning iOS Photo Caches"
rm -rf /Users/$var/Pictures/iPhoto\ Library/iPod\ Photo\ Cache/*
echo "Done cleaning from /Users/$var/Pictures/iPhoto Library/iPod Photo Cache"
else
echo ""
fi
#Application Caches and Logs
echo "Cleaning Application Caches and Logs"
for x in $(ls ~/Library/Containers/) 
do 
    echo "cleaning ~/Libarary/Containers/$x/Data/Library/Caches"
    rm -rf ~/Library/Containers/$x/Data/Library/Caches/*
    rm -rf ~/Library/Containers/$x/Data/Library/Logs/*
    echo "done cleaning ~/Library/Containers/$x/Data/Library/Caches"
done
echo "Done cleaning Application Caches"
#Terminal Caches (.asl files)
echo "If your Terminal is running slow, cleaning out the *.asl log files may help speed it up - would you like to move the files to the Trash [y/n]?"
read line
case "$line" in
    n|N) echo "Skipping Terminal cleaning..."
         sleep 2
        ;;
    y|Y) sudo rm -rf /private/var/log/asl/*.asl
         #sudo mv /private/var/log/asl/*.asl ~/.Trash
         #sudo rm -i /private/var/log/asl/*.asl
         echo "Done cleaning Terminal Caches"
        ;;
esac
#Bash history cleaning
echo "Would you like to clear your Bash sessions/history [y/n]?"
read line
case "$line" in
    n|N) echo "Skipping Bash sessions/history cleaning..."
         sleep 2
        ;;
    y|Y) sudo rm -rf /var/root/.sh_history
         rm -rf ~/.bash_history
         rm -rf ~/.bash_sessions/*
         echo "Done cleaning Bash history/sessions"
        ;;
esac
#Xcode DerivedData & Archives (if Xcode exists in /Applications directory)
if [ -d "/Applications/Xcode.app" ]; then
echo "Do you want to clean Xcode DerivedData, Archives, and iOS Device Logs [y/n]?"
read line
case "$line" in
    n|N) echo "Skipping Xcode cleaning..."
         sleep 2
        ;;
    y|Y) echo "cleaning Xcode DerivedData Archives, and iOS Device Logs"
         rm -rf ~/Library/Developer/Xcode/DerivedData/*
         rm -rf ~/Library/Developer/Xcode/Archives/*
         rm -rf ~/Library/Developer/Xcode/iOS\ Device\ Logs/*
        ;;
esac
fi
#Mail Downloads Attachments
echo "Would you like to delete downloaded Mail attachments [y/n]?"
read line
case "$line" in
    n|N) echo "Skipping removing downloaded Mail attachments..."
         sleep 2
        ;;
    y|Y) rm -rf ~/Library/Containers/com.apple.mail/Data/Library/Mail\ Downloads/*
        ;;
esac
#Permissions Repair (OS X 10.11 gets rid of permission repair, therefore not required)
ver=`sw_vers -productVersion | cut -d "." -f 2`
if (( $ver < 11 )); then
echo "Would you like to Repair your Disk Permissions [y/n]?"
read line
case "$line" in
    n|N) echo "Skipping Disk Permissions Fix..."
         sleep 2
        ;;
    y|Y) sudo diskutil repairPermissions /
        ;;
esac
else
echo ""
fi
#Empty Trash if their are any items in the Trash
if [ "$(ls -A ~/.Trash 2> /dev/null | cut -f1 -d".")" == "" ]; then
echo ""
else
echo "There are items in your Trash, do you want to empty it now [y/n]?"
read line
case "$line" in
    n|N) echo "Skipping Emptying the Trash..."
         sleep 2
        ;;
    y|Y) echo "Emptying the Trash..."
         rm -rf ~/.Trash/*
        ;;
esac
fi
echo "To gain even more free space, download and run Monolingual to remove language packs you don't use from http://ingmarstein.github.io/Monolingual/"

#Calculate used space
ffs=$(df -H / | egrep '/$' | awk '{print $4}' | cut -d "G" -f 1)
echo "Total free space after cleanup is "$ffs"GB"
a="$ifs"
b="$ffs"
tot=`echo "$ffs - $ifs" | bc`
if (( $tot >= 1 )); then
echo "You saved a total of "$tot"GB of space"
else
echo "You saved less than 1GB of space"
fi

#Saving for later...
#fispace=$(df -h | grep -A1 /dev/disk1 | sed -n 1p | awk '{ print $7 }')
#fis="${fispace:0:2}.${fispace:2:2}"
#echo "Total free space after cleanup is "$fis"GB and "$fispace"kb"
#a="$inspace"
#b="$fispace"
#tot=`echo "$b - $a" | bc`
#echo "You saved a total of "$tot"kb of space"
#echo "Before you had "$ins"GB of free space, now you have "$fis"GB free!"
