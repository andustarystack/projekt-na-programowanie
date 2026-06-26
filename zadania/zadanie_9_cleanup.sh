#!/bin/bash
cd kopie/ || exit
for plik in *.zip; do
    rok=$(echo "$plik" | cut -c 1-4)
    miesiac=$(echo "$plik" | cut -c 6-7)
    mkdir -p "$rok/$miesiac"
    mv "$plik" "$rok/$miesiac/"
done
cd ..
#jakieśbzdury
