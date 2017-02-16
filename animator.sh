#!/bin/sh

# welcome message (why not)
echo "Creating an awesome animation..."

# get all the ugly PNGs and mix them into an awesome GIF
convert -layers OptimizePlus src/*.png animation.gif

# an awesome GIF is not awesome if is not optimized

crop="--crop 5,86-1440,900"
resize="--resize-fit 800x800"
color="-k64"
optimization="-O3"
output="-o animation.gif animation.gif"

gifsicle $crop $resize $color $optimization $output

# set a timeline to make the animation more interesting

timeline='-b animation.gif'

for entry in src/*
do
  frame_num=$entry
  frame_num=${frame_num#src/}
  frame_num=${frame_num#0}
  frame_num=${frame_num%.png}
  
  frame_delay=7
  if [[ $frame_num == *"-"* ]]; then
    frame_delay=$(echo $frame_num | cut -f2 -d-)
    frame_num=$(echo $frame_num | cut -f1 -d-)
  fi
  timeline+=" -d$frame_delay #$frame_num"
done

gifsicle $timeline

# that's it!
echo "Done! Enjoy your creation! (and don't forget popcorns)"
