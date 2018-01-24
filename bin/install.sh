#!/bin/bash

DB=$1
VER=$2
DIR="../sql/version-$VER"

if [ -d "$DIR" ]; then

  mysql ${DB} < ${DIR}/create_table.sql
  mysql ${DB} < ${DIR}/views.sql
  mysql ${DB} < ${DIR}/function.sql
  mysql ${DB} < ${DIR}/insert_data.sql

else
  echo "\nNo such version\n"
fi
