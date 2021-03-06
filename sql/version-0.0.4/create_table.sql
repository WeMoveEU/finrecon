DROP TABLE IF EXISTS stripe_subscriptions;
CREATE TABLE stripe_subscriptions (
  id VARCHAR(255) PRIMARY KEY,
  customer_id VARCHAR(255) NOT NULL,
  customer_description VARCHAR(255),
  customer_email VARCHAR(255),
  plan VARCHAR(255),
  quantity INT UNSIGNED,
  interval_unit VARCHAR(255),
  amount DECIMAL(20, 2) NOT NULL,
  status VARCHAR(255),
  created_date DATETIME,
  start_date DATETIME,
  current_period_start_date DATETIME,
  current_period_end_date DATETIME,
  trial_start_date DATETIME,
  trial_end_date DATETIME,
  application_fee_percent DECIMAL(20, 2),
  coupon VARCHAR(255),
  tax_percent DECIMAL(20, 2),
  cancelled_date DATETIME,
  cancel_at_period_end BOOL,
  ended_date DATETIME
);

DROP TABLE IF EXISTS stripe_payments;
CREATE TABLE stripe_payments (
  id VARCHAR(255) PRIMARY KEY,
  customer_id VARCHAR(255) NOT NULL,
  card_id VARCHAR(255) NOT NULL,
  invoice_id VARCHAR(255) NULL,
  description VARCHAR(255),
  seller_message VARCHAR(255),
  created_date DATETIME,
  amount DECIMAL(20, 2) NOT NULL,
  amount_refunded DECIMAL(20, 2) NOT NULL,
  currency CHAR(3) NOT NULL,
  converted_amount DECIMAL(20, 2) NOT NULL,
  converted_amount_refunded DECIMAL(20, 2) NOT NULL,
  fee DECIMAL(20, 2) NOT NULL,
  tax DECIMAL(20, 2) NOT NULL,
  converted_currency CHAR(3) NOT NULL,
  mode VARCHAR(255),
  status VARCHAR(255),
  statement_description VARCHAR(255),
  customer_description VARCHAR(255),
  customer_email VARCHAR(255),
  captured BOOL,
  card_last4 VARCHAR(4) NOT NULL,
  card_brand VARCHAR(255) NOT NULL,
  card_funding VARCHAR(255) NOT NULL,
  card_exp_month INT NOT NULL,
  card_exp_year INT NOT NULL,
  card_name VARCHAR(255),
  card_address_line1 VARCHAR(255),
  card_address_line2 VARCHAR(255),
  card_address_city VARCHAR(255),
  card_address_state VARCHAR(255),
  card_address_country VARCHAR(255),
  card_address_zip VARCHAR(255),
  card_issue_country CHAR(2),
  card_fingerprint VARCHAR(255),
  card_cvc_status VARCHAR(255),
  card_avs_zip_status VARCHAR(255),
  card_avs_line1_status VARCHAR(255),
  card_tokenization_method VARCHAR(255),
  disputed_amount VARCHAR(255),
  dispute_status VARCHAR(255),
  dispute_reason VARCHAR(255),
  dispute_date DATETIME,
  dispute_evidence_due_date DATETIME,
  payment_source_type VARCHAR(4),
  destination VARCHAR(255),
  transfer VARCHAR(255),
  interchange_costs DECIMAL(20, 2),
  merchant_service_charge DECIMAL(20, 2),
  transfer_group VARCHAR(255)
);

DROP TABLE IF EXISTS stripe_invoices;
CREATE TABLE stripe_invoices (
  id VARCHAR(255) PRIMARY KEY,
  payment_id VARCHAR(255) ,
  customer_id VARCHAR(255) NOT NULL,
  subscription_id VARCHAR(255) NULL,
  amount_due DECIMAL(20, 2),
  application_fee VARCHAR(255),
  billing VARCHAR(255),
  closed BOOL NOT NULL,
  currency CHAR(3) NOT NULL ,
  date1 DATETIME NOT NULL,
  discount VARCHAR(255),
  due_date DATETIME,
  ending_balance VARCHAR(255),
  forgiven BOOL NOT NULL,
  number VARCHAR(255),
  paid BOOL NOT NULL,
  period_end_date DATETIME,
  period_start_date DATETIME,
  starting_balance VARCHAR(255),
  subtotal DECIMAL(20, 2),
  tax DECIMAL(20, 2),
  tax_percent DECIMAL(20, 2),
  total DECIMAL(20, 2),
  customer_email VARCHAR(255),
  amount_paid DECIMAL(20, 2)
);
