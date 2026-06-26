#!/bin/bash
cd zdjecia/ || exit
magick montage -label '%f' -tile 2x4 -geometry +10+10 -page A4 *.jpg portfolio.pdf
cd ..
