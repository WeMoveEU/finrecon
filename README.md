# Finance Reconciliation

## How to install

* go to bin/ directory
* sh install.sh DATABASE VERSION

## How to load paypal

* copy csv FILE to `secure_file_priv` localization, probably `/var/lib/mysql-files/`
* go to bin/ directory
* run script one of the scripts
  * sh load-paypal.sh DATABASE FILE
  * sh load-bank.sh DATABASE FILE
  * sh load-stripe.sh DATABASE FILE
