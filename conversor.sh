#!/bin/bash

#This is a simple batch convert script using ffmpeg

printf "[1] Convert all video files audio tracks to AAC\n[2] Remove sub track from all videos\n: "
read -n 1 -r
if [[ $REPLY =~ ^[1]$ ]];
then
    printf "\nConvert all audio tracks?\nY/N: " 
    read -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]];
    then
       mkdir Converted
       for i in *.mp4; do ffmpeg -i "$i" -map 0:a:? -map 0:s? -map 0:v:? -c:v copy -c:a aac "Converted/${i%.*}AAC.mp4"; done
       for i in *.avi; do ffmpeg -i "$i" -map 0:a:? -map 0:s? -map 0:v:? -c:v copy -c:a aac "Converted/${i%.*}AAC.avi"; done
       for i in *.mkv; do ffmpeg -i "$i" -map 0:a:? -map 0:s? -map 0:v:? -c:v copy -c:a aac "Converted/${i%.*}AAC.mkv"; done

     fi
    if [[ $REPLY =~ ^[Nn]$ ]];
    then
        printf "\n"
        read -p "Audio track number: " int2
        mkdir convertidos
        for i in *.mp4; do ffmpeg -i "$i" -map 0:a:$int2 -map 0:s? -map 0:v:? -c:v copy -c:a aac "Converted/${i%.*}AAC.mp4"; done
        for i in *.avi; do ffmpeg -i "$i" -map 0:a:$int2 -map 0:s? -map 0:v:? -c:v copy -c:a aac "Converted/${i%.*}AAC.avi"; done
        for i in *.mkv; do ffmpeg -i "$i" -map 0:a:$int2 -map 0:s? -map 0:v:? -c:v copy -c:a aac "Converted/${i%.*}AAC.mkv"; done
    fi
fi

if [[ $REPLY =~ ^[2]$ ]];
then
   printf "\nSub track number: "
   read  int2
   mkdir Subtitles
   for i in *.mkv; do ffmpeg -i "$i" -map 0:s:int2 "Subtitles/${i%.*}.ass"; done
fi
