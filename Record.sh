#!/bin/bash

files="/home/pi/Videos/*"
fileAry=()
dirAry=()
runCmd="test"
python /home/pi/Desktop/Camera.py

NUMBER_OF_FILE=$(ls /mnt/NAS/ | wc -l)
if [ $NUMBER_OF_FILE == 0 ] ; then
        sudo mount -t cifs //NASIP/NASDIR /mnt/NAS cifs username=NASUN,password=NASPW,file_mode=0777,dir_mode=0777,iocharset=utf8,defaults,vers=1.0
        echo "Completed to file-mounting"
fi

for filePath in $files; do
        if [ -f $filePath ] ; then
                fileAry+=("$filePath")
        elif [ -d $filePath ] ; then
                dirAry+=("$filePath")
        fi
done

echo "All files in /home/pi/Videos"
for i in ${fileAry[@]}; do
          echo $i
        if [ `echo $i | grep 'converted.h264'` ] ; then
                sudo mv  $i /mnt/NAS/Original
        elif [ `echo $i | grep 'converted.mp4'` ] ; then
                sudo mv  $i /mnt/NAS
        else
                runCmd="ffmpeg -i "$i" -s 640x480 -r 15 "$i".mp4"
                $runCmd
                add1="converted.h264"
                add2="converted.mp4"
                mv  $i $i$add1
                mv  $i".mp4" $i$add2

                sudo mv $i$add1 /mnt/NAS/Original
                sudo mv $i$add2 /mnt/NAS
        fi
done

for i in ${fileAry[@]}; do
        echo $i
done
