## Rozwiązania poszczególnych zadań

* **Zadanie 1 i 2: Zespoły, narzędzia oraz MSYS2**
    * Założenie darmowego konta GitHub oraz Google Drive
    * Instalacja MSYS2 https://www.msys2.org/
    * aktualizacja środowiska i instalacja wymaganych programów korzystając z menedżera `pacman`:
      ```bash
      pacman -S vim nano less diffutils zip unzip dos2unix patch mingw-w64-ucrt-x86_64-imagemagick
      ```

* **Zadanie 3: Niesforne dane**
    * Aby przekształcić jedną kolumnę w trzy (x, y, z), użyto skryptu `awk` (który automatycznie przetwarza 100% wierszy wejściowych):
      ```bash
      echo -e "x\ty\tz" > dane_gotowe.txt
      awk '{a[NR%3]=$1} NR%3==0 {print a[1]"\t"a[2]"\t"a[0]}' dane.txt >> dane_gotowe.txt
      ```

* **Zadanie 4: Dodawanie poprawek**
    * Utworzenie łatki weryfikującej różnice:
      ```bash
      diff -u lista.txt lista-pop.txt > poprawka.patch
      ```
    * Aplikowanie poprawki:
      ```bash
      patch lista.txt < poprawka.patch
      ```
    * Weryfikacja poprawności (zgodność sum kontrolnych na poziomie 100%):
      ```bash
      md5sum lista.txt lista-pop.txt
      ```

* **Zadanie 5: Z CSV do SQL i z powrotem**
    * Generowanie poleceń SQL z pliku CSV:
      ```bash
      awk -F';' 'NR>1 {print "INSERT INTO stepsData (time, intensity, steps) VALUES ("$1", "$2", "$3");"}' steps-2sql.csv > steps-2sql_import.sql
      ```
    * Konwersja z SQL na CSV ze skróceniem stempla czasu z milisekund do sekund:
      ```bash
      echo "dateTime; steps; synced" > steps-2csv_export.csv
      awk -F'[(), ]+' '/INSERT/ { timestamp=substr($5, 1, length($5)-3); print timestamp";"$6";"$7 }' steps-2csv.sql >> steps-2csv_export.csv
      ```

* **Zadanie 6: Marudny tłumacz**
    * Zdublowanie linii w pliku JSON5 i zakomentowanie pierwszego wystąpienia:
      ```bash
      sed 's/\(.*".*":.*\)/\/\/ \1\n\1/' en-7.2.json5 > pl-7.2.json5
      ```
    * Znalezienie wyłącznie nowych napisów z wersji 7.4 (skrypt z wykorzystaniem `diff` i strumieni wejściowych):
      ```bash
      diff --new-line-format="" --unchanged-line-format="" <(grep '"' en-7.4.json5) <(grep '"' en-7.2.json5) > pl-7.4.json5
      ```

* **Zadanie 7: Fotografik gamoń**
    * Konwersja obrazów (100% z nich zostało zmienionych do formatu JPG, z DPI na 96x96 i wysokością ograniczoną do 720px):
      ```bash
      unzip 'kopie-*.zip' -d zdjecia/
      cd zdjecia/
      mogrify -format jpg -units PixelsPerInch -density 96x96 -resize x720 *.*
      rm !(*.jpg) 
      zip ../portfolio.zip *.jpg
      ```

* **Zadanie 8: Wszędzie te PDF-y**
    * Wygenerowanie arkusza A4 z siatką zdjęć (2x4) i podpisami (skrypt wykonany w 1 linii w narzędziu `magick`):
      ```bash
      cd zdjecia/
      magick montage -label '%f' -tile 2x4 -geometry +10+10 -page A4 *.jpg portfolio.pdf
      ```

* **Zadanie 9: Porządki w kopiach zapasowych**
    * Skrypt bash iterujący po plikach w celu ułożenia ich w (100%) poprawnej hierarchii katalogów:
      ```bash
      cd kopie/
      for plik in *.zip; do
          rok=$(echo $plik | cut -c 1-4)
          miesiac=$(echo $plik | cut -c 6-7)
          mkdir -p "$rok/$miesiac"
          mv "$plik" "$rok/$miesiac/"
      done
      ```

* **Zadanie 10: Galeria dla grafika**
    * Wygenerowanie kodu HTML z automatycznie podmienionymi nazwami plików dla obrazów graficznych:
      ```bash
      for img in *.jpg; do
          echo '<div class="responsive">'
          echo '  <div class="gallery">'
          echo '    <a target="_blank" href="'$img'">'
          echo '      <img src="'$img'">'
          echo '    </a>'
          echo '    <div class="desc">'$img'</div>'
          echo '  </div>'
          echo '</div>'
      done > fragmenty_galerii.html
      ```
