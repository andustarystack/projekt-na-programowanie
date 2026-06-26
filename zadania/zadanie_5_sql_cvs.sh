#!/bin/bash
awk -F';' 'NR>1 {print "INSERT INTO stepsData (time, intensity, steps) VALUES ("$1", "$2", "$3");"}' steps-2sql.csv > steps-2sql_import.sql

echo "dateTime; steps; synced" > steps-2csv_export.csv
awk -F'[(), ]+' '/INSERT/ { timestamp=substr($5, 1, length($5)-3); print timestamp";"$6";"$7 }' steps-2csv.sql >> steps-2csv_export.csv
