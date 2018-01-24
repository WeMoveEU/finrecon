#!/bin/bash

DB=$1
VER=$2
DIR="../sql/version-$VER"

if [ -d "$DIR" ]; then

  mysql ${DB} < ../sql/version-${VER}/create_table.sql
  mysql ${DB} < ../sql/version-${VER}/views.sql
  mysql ${DB} < ../sql/version-${VER}/function.sql
  mysql ${DB} < ../sql/version-${VER}/insert_data.sql

else
  echo "\nNo such version\n"
fi
