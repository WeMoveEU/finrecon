#!/usr/bin/env bash

DB=$1
FILE=$2

QUERY="LOAD DATA INFILE '/var/lib/mysql-files/${FILE}'
INTO TABLE bank
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
IGNORE 0 LINES
(@id1, @id2, @id3, @operation_date, @record_date, @subject, @group_id, @amount, @direction,
 @name1, @name2, @bic, @iban, @text1, @text2, @text3, @text4, @text5,
 @text6, @text7, @text8, @text9, @text10, @text11, @text12, @text13, @text14, @text15,
 @dummy1, @dummy2)
SET
  id1 = @id1,
  id2 = @id2,
  id3 = @id3,
  operation_date = str_to_date(@operation_date, '%d.%m.%Y'),
  record_date = str_to_date(@record_date, '%d.%m.%Y'),
  subject = @subject,
  group_id = @group_id,
  amount = @amount,
  direction = CASE WHEN @direction = '+' THEN 'd' ELSE 'c' END,
  first_last_name = md5(CONCAT(@name1, @name2)),
  bic = @bic,
  iban = md5(@iban),
  text1 = @text1,
  text2 = @text2,
  text3 = @text3,
  text4 = @text4,
  text5 = @text5,
  text6 = @text6,
  text7 = @text7,
  text8 = @text8,
  text9 = @text9,
  text10 = @text10,
  text11 = @text11,
  text12 = @text12,
  text13 = @text13,
  text14 = @text14,
  text15 = @text15,
  text_merged = CONCAT(@text1, @text2, @text3, @text4, @text5,
                       @text6, @text7, @text8, @text9, @text10,
                       @text11, @text12, @text13, @text14, @text15),
  source =
    CASE
      WHEN locate('PayPal', CONCAT(@name1, @name2)) > 0 THEN 'paypal'
      WHEN locate('Stripe', CONCAT(@name1, @name2)) > 0 THEN 'stripe'
      WHEN locate('EBICS-Euro-Lastschriften', @subject) > 0 THEN 'sepa'
      ELSE 'bank'
    END"

mysql ${DB} -e "${QUERY}"
echo "\n"
