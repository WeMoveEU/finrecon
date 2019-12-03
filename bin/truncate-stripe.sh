#!/usr/bin/env bash

DB=$1

QUERY="TRUNCATE TABLE stripe_subscriptions"

mysql ${DB} -e "${QUERY}"
echo "subscriptions - done\n"


QUERY="TRUNCATE TABLE stripe_payments"

mysql ${DB} -e "${QUERY}"
echo "payments - done\n"


QUERY="TRUNCATE TABLE stripe_invoices"

mysql ${DB} -e "${QUERY}"
echo "invoices - done\n"

echo "Live Long and Prosper!"
