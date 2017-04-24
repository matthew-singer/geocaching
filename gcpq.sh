#!/bin/bash

#This script will unzip pocket queries and place the gpx files on the SD card of the gps.


#cd ~/Desktop/export/GPX/ 

echo "Do you wish to delete all Pocket Query files currently on the device?"
echo \"yes\" or \"no\"
read rem

echo Do you want to keep the waypoint files? 
echo \"yes\" or \"no\"
read wpt

echo Do you wish to delete the original .zip files?
echo \"yes\" or \"no\"
read delzip

echo Convert found caches to unfound?
echo \"yes\" or \"no\"
read found

### No longer necessary as Geocaching.com reverted back to the old name ###
#echo Do you need to correct Mystery caches?
#echo Type \"yes\" or \"no\".
#read myst

if [ "$rem" = "yes" ];
then
echo Removing previously installed PQ files.
rm /Volumes/GPS\ SD\ CARD/Garmin/gpx/[0-9]*.gpx
fi

for i in *.zip
do unzip -o $i -d /Volumes/GPS\ SD\ CARD/Garmin/gpx &
done
wait

if [ "$delzip" = "yes" ]
then
echo Deleting downloaded .zip files.
rm *.zip
fi


if [ "$wpt" = "no" ];
then
echo "Removing waypoints files."
rm /Volumes/GPS\ SD\ CARD/Garmin/gpx/*wpts.gpx
fi

if [ "$found" = "yes" ];
then
echo "Changing found to unfound."
cd /Volumes/GPS\ SD\ CARD/Garmin/GPX/
for fgpx in [0-9]*.gpx
do echo "$fgpx" 
sed -i -e 's/Geocache Found/Geocache/g' "$fgpx"
done 
rm *-e
fi

### No longer necessary as Geocaching.com reverted back to the old name ###
#if [ "$myst" = "yes" ];
#then
#cd /Volumes/GPS\ SD\ CARD/Garmin/GPX

#for file in [0-9]*.gpx
#do echo fixing $file
#sed -i.bak "s/Mystery Cache/Unknown Cache/g" "$file"
#done

#rm *.bak
#fi

echo "Done!"

exit
