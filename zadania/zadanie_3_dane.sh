#!/bin/bash
# Pliku z danymi w trzech kolumnach
echo -e "x\ty\tz" > dane_gotowe.txt
awk '{a[NR%3]=$1} NR%3==0 {print a[1]"\t"a[2]"\t"a[0]}' dane.txt >> dane_gotowe.txt
