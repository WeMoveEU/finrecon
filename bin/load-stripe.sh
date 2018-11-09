#!/usr/bin/env bash

DB=$1

QUERY="LOAD DATA INFILE '/var/lib/mysql-files/stripe_subscriptions.csv'
REPLACE
INTO TABLE stripe_subscriptions
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
IGNORE 1 LINES
(@id, @customer_id, @customer_description, @customer_email, @plan, @quantity, @interval_unit, @amount, @status,
 @created_date, @start_date, @current_period_start_date, @current_period_end_date,
 @trial_start_date, @trial_end_date, @application_fee_percent, @coupon, @tax_percent,
  @cancelled_date, @cancel_at_period_end, @ended_date)
SET
  id = @id,
  customer_id = @customer_id,
  customer_description = @customer_description,
  customer_email = md5(@customer_email),
  plan = @plan,
  quantity = @quantity,
  interval_unit = @interval_unit,
  amount = @amount / 100,
  status = @status,
  created_date = @created_date,
  start_date = @start_date,
  current_period_start_date = @current_period_start_date,
  current_period_end_date = @current_period_end_date,
  trial_start_date = IF(@trial_start_date != '', @trial_start_date, NULL),
  trial_end_date = IF(@trial_end_date != '', @trial_end_date, NULL),
  application_fee_percent = IF(@application_fee_percent != '', @application_fee_percent, NULL),
  coupon = IF(@coupon != '', @coupon, NULL),
  tax_percent = IF(@tax_percent != '', @tax_percent, NULL),
  cancelled_date = IF(@cancelled_date != '', @cancelled_date, NULL),
  cancel_at_period_end = IF(@cancel_at_period_end = 'false', FALSE, TRUE),
  ended_date = IF(@ended_date != '', @ended_date, NULL)"

mysql ${DB} -e "${QUERY}"
echo "subscriptions - done\n"


QUERY="LOAD DATA INFILE '/var/lib/mysql-files/stripe_payments.csv'
REPLACE
INTO TABLE stripe_payments
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
IGNORE 1 LINES
(@id, @description, @seller_message, @created_date, @amount, @amount_refunded, @currency, @converted_amount, @converted_amount_refunded,
 @fee, @tax, @converted_currency, @mode, @status, @statement_description, @customer_id, @customer_description, @customer_email,
 @captured, @card_id, @card_last4, @card_brand, @card_funding, @card_exp_month, @card_exp_year, @card_name,
 @card_address_line1, @card_address_line2, @card_address_city, @card_address_state, @card_address_country,
 @card_address_zip, @card_issue_country, @card_fingerprint, @card_cvc_status, @card_avs_zip_status, @card_avs_line1_status,
 @card_tokenization_method, @disputed_amount, @dispute_status, @dispute_reason, @dispute_date, @dispute_evidence_due_date,
 @invoice_id, @payment_source_type, @destination, @transfer, @interchange_costs, @merchant_service_charge, @transfer_group,
 @kind, @nonprofit_id)
SET
  id = @id,
  customer_id = @customer_id,
  card_id = @card_id,
  invoice_id = @invoice_id,
  description = @description,
  seller_message = @seller_message,
  created_date = @created_date,
  amount = REPLACE(@amount, ',', '') / 100,
  amount_refunded = REPLACE(@amount_refunded, ',', '') / 100,
  currency = UPPER(@currency),
  converted_amount = REPLACE(@converted_amount, ',', '') / 100,
  converted_amount_refunded = REPLACE(@converted_amount_refunded, ',', '') / 100,
  fee = REPLACE(@fee, ',', '') / 100,
  tax = REPLACE(@tax, ',', '') / 100,
  converted_currency = UPPER(@converted_currency),
  mode = @mode,
  status = @status,
  statement_description = @statement_description,
  customer_description = @customer_description,
  customer_email = MD5(@customer_email),
  captured = IF(@captured = 'false', FALSE, TRUE),
  card_last4 = lpad(@card_last4, 4, 0),
  card_brand = @card_brand,
  card_funding = @card_funding,
  card_exp_month = @card_exp_month,
  card_exp_year = @card_exp_year,
  card_name = MD5(@card_name),
  card_address_line1 = @card_address_line1,
  card_address_line2 = @card_address_line2,
  card_address_city = @card_address_city,
  card_address_state = @card_address_state,
  card_address_country = @card_address_country,
  card_address_zip = @card_address_zip,
  card_issue_country = @card_issue_country,
  card_fingerprint = @card_fingerprint,
  card_cvc_status = @card_cvc_status,
  card_avs_zip_status = @card_avs_zip_status,
  card_avs_line1_status = @card_avs_line1_status,
  card_tokenization_method = @card_tokenization_method,
  disputed_amount = @disputed_amount,
  dispute_status = @dispute_status,
  dispute_reason = @dispute_reason,
  dispute_date = IF(@dispute_date != '', @dispute_date, NULL),
  dispute_evidence_due_date = IF(@dispute_evidence_due_date != '', @dispute_evidence_due_date, NULL),
  payment_source_type = @payment_source_type,
  destination = @destination,
  transfer = @transfer,
  interchange_costs = REPLACE(@interchange_costs, ',', '') / 100,
  merchant_service_charge = REPLACE(@merchant_service_charge, ',', '') / 100,
  transfer_group = @transfer_group,
  kind = @kind,
  nonprofit_id = @nonprofit_id"

mysql ${DB} -e "${QUERY}"
echo "payments - done\n"


QUERY="LOAD DATA INFILE '/var/lib/mysql-files/stripe_invoices.csv'
REPLACE
INTO TABLE stripe_invoices
COLUMNS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '\"'
IGNORE 1 LINES
(@id, @amount_due, @application_fee, @billing, @payment_id, @closed, @currency, @customer_id,
 @date1, @discount, @due_date, @ending_balance, @forgiven, @number, @paid, @period_end_date, @period_start_date,
 @starting_balance, @subscription_id, @subtotal, @tax, @tax_percent, @total, @customer_email, @amount_paid)
SET
  id = @id,
  payment_id = @payment_id,
  customer_id = @customer_id,
  subscription_id = @subscription_id,
  amount_due = REPLACE(@amount_due, ',', '') / 100,
  application_fee = @application_fee,
  billing = @billing,
  closed = IF(@closed = 'false', FALSE, TRUE),
  currency = UPPER(@currency),
  date1 = @date1,
  discount = @discount,
  due_date = IF(@due_date != '', @due_date, NULL),
  ending_balance = @ending_balance,
  forgiven = IF(@forgiven = 'false', FALSE, TRUE),
  number = @number,
  paid = IF(@paid = 'false', FALSE, TRUE),
  period_end_date = @period_end_date,
  period_start_date = @period_start_date,
  starting_balance = @starting_balance,
  subtotal = REPLACE(@subtotal, ',', '') / 100,
  tax = REPLACE(@tax, ',', '') / 100,
  tax_percent = IF(@tax_percent != '', @tax_percent, NULL),
  total = REPLACE(@total, ',', '') / 100,
  customer_email = md5(@customer_email),
  amount_paid = REPLACE(@amount_paid, ',', '') / 100
  "

mysql ${DB} -e "${QUERY}"
echo "invoices - done\n"

echo "Live Long and Prosper!"
