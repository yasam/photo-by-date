#!/bin/sh

if [ $# != 1 ]; then
    echo usage: $0 PHOTO_DIR
    exit 1;
fi

FOLDER=$1



get_file_date()
{

    DT=`exiftool -CreateDate $F -d %Y-%m | cut -d : -f 2 | xargs echo`

    if [ "$DT" == "" ]; then
	DT=`exiftool -filemodifydate $F -d %Y-%m | cut -d : -f 2 | xargs echo`
    fi
    echo $DT
}


classify_files()
{
    TYPE=$1
    D=$2
    EXT=$3
    for F in $D/*.$EXT;
    do
	#echo $F
	DT=`get_file_date $F`

	if [ "$DT" == "" ]; then
	    echo skipping $F;
	    continue;
	fi

	#echo $DT
	mkdir -p $D/$TYPE-$DT

	#echo $D/$DT/

	mv -v $F $D/$TYPE-$DT/
    done
}


classify_files IMG $FOLDER "JPG"
classify_files IMG $FOLDER "PNG"
classify_files IMG $FOLDER "jpg"
classify_files IMG $FOLDER "png"

classify_files MOV $FOLDER "MOV"
classify_files MOV $FOLDER "mp4"
classify_files MOV $FOLDER "mov"
classify_files MOV $FOLDER "MP4"


