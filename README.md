# Finance Reconciliation

## How to install

* set mysql account with proper permissions

```
CREATE USER 'USER'@'localhost';
GRANT SELECT, PROCESS, FILE, SHOW DATABASES, CREATE TEMPORARY TABLES, SHOW VIEW ON *.* TO 'USER'@'localhost';
```

* git clone this repo wherever you want
* go to bin/ directory
* sh install.sh DATABASE VERSION
    * for each version beginning with the lowest version
    * VERSION == 0.0.1, 0.0.2

## How to load paypal or bank

* copy csv FILE to `secure_file_priv` localization, probably `/var/lib/mysql-files/`
* go to bin/ directory
* run script one of the scripts
  * sh load-paypal.sh DATABASE FILE
  * sh load-bank.sh DATABASE FILE

## How to load stripe

* copy csv files to `secure_file_priv` localization, probably `/var/lib/mysql-files/`
  * invoices.csv
  * payments.csv
  * subscriptions.csv
* go to bin/ directory
* run the script
  * sh load-stripe.sh DATABASE
