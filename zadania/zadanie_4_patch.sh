#!/bin/bash
#xd
diff -u lista.txt lista-pop.txt > poprawka.patch
patch lista.txt < poprawka.patch
md5sum lista.txt lista-pop.txt
