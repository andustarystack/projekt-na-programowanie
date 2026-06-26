#!/bin/bash
cd zdjecia/ || exit
for img in *.jpg; do
    echo '<div class="responsive">'
    echo '  <div class="gallery">'
    echo '    <a target="_blank" href="'$img'">'
    echo '      <img src="'$img'">'
    echo '    </a>'
    echo '    <div class="desc">'$img'</div>'
    echo '  </div>'
    echo '</div>'
done > ../fragmenty_galerii.html
cd ..
