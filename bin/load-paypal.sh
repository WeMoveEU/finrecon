#!/bin/bash

DB=$1
FILE=$2

QUERY="LOAD DATA INFILE '/var/lib/mysql-files/${FILE}'
INTO TABLE paypal
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES
(@ddate, @dtime, @time_zone, @first_last_name, @type, @status, @currency, @gross, @fee, @net, @from_email, @to_email,
 @transaction_id, @shipping_address, @address_status, @item_title, @item_id, @shipping_amount, @insurance_amount,
 @sales_tax, @option_1_name, @option_1_value, @option_2_name, @option_2_value, @reference_txn_id, @invoice_number,
 @custom_number, @quantity, @receipt_id, @balance, @address_line_1, @address_line_2, @city, @state, @postal_code,
 @country, @phone_number, @subject, @note, @country_code, @balance_impact)
SET
  ddate = str_to_date(@ddate, '%c/%e/%Y'),
  dtime = @dtime,
  time_zone = @time_zone,
  first_last_name = md5(@first_last_name),
  type = @type,
  status = @status,
  currency = @currency,
  gross = replace(@gross, ',', '.'),
  fee = replace(@fee, ',', '.'),
  net = replace(@net, ',', '.'),
  from_email = md5(@from_email),
  to_email = @to_email,
  transaction_id = @transaction_id,
  shipping_address = md5(@shipping_address),
  address_status = @address_status,
  item_title = @item_title,
  item_id = @item_id,
  shipping_amount = CASE WHEN @shipping_amount = '' THEN NULL ELSE @shipping_amount END,
  insurance_amount = CASE WHEN @insurance_amount = '' THEN NULL ELSE @insurance_amount END,
  sales_tax = CASE WHEN @sales_tax = '' THEN NULL ELSE @sales_tax END,
  option_1_name = @option_1_name,
  option_1_value = @option_1_value,
  option_2_name = @option_2_name,
  option_2_value = @option_2_value,
  reference_txn_id = @reference_txn_id,
  invoice_number = @invoice_number,
  custom_number = @custom_number,
  quantity = CASE WHEN @quantity = '' THEN NULL ELSE @quantity END,
  receipt_id = @receipt_id,
  balance = replace(@balance, ',', '.'),
  address_line_1 = @address_line_1,
  address_line_2 = @address_line_2,
  city = @city,
  state = @state,
  postal_code = @postal_code,
  country = @country,
  phone_number = md5(@phone_number),
  subject = @subject,
  note = @note,
  country_code = @country_code,
  balance_impact = @balance_impact"

mysql ${DB} -e ${QUERY}
echo -e "\n"
