#!/bin/bash
shopt -s extglob
unzip -o 'kopie-*.zip' -d zdjecia/
cd zdjecia/ || exit
mogrify -format jpg -units PixelsPerInch -density 96x96 -resize x720 *.*
rm -f !(*.jpg) 
zip ../portfolio.zip *.jpg
cd ..
