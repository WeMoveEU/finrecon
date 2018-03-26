# Finance Reconciliation

## How to install

* go to bin/ directory
* sh install.sh DATABASE VERSION

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
