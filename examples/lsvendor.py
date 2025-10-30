#!/usr/bin/python3
# https://docs.python.org/3/library/csv.html
import sys
import csv
def get_vendor_name(vendor_id):
    with open('oui.csv') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            if row['Assignment'] == vendor_id:
                return row['Organization Name']
for line in sys.stdin.readlines():
    a = list(map(str.strip, line.split('|')))
    vendor_id = a[2][:8].replace(':', '')
    print (a[0], "\t", a[2], "\t", get_vendor_name(vendor_id))

