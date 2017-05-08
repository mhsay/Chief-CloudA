# example

TODO: Enter the cookbook description here.

# Sample Run List


default['mybb']['dnsname']
default['mybb']['admin_email']
default['mybb']['dbname']
default['mybb']['dbhost']
default['mybb']['dbport']
default['mybb']['dbuser']
default['mybb']['dbpass']

{
    "mybb": {
        "dnsname": "123.aws.com",
        "admin_email": "test@example.com",
        "dbname": "mybbdb",
        "dbhost": "mm14eij32vdcnkp.c3leytrkwaba.us-west-2.rds.amazonaws.com",
        "dbport": "3306",
        "dbuser": "sysdba",
        "dbpass": "ha513"
    },
    "datadog": {
        "apikey": "1a713ba658695272bc429eb16aef13cd"
    },
  "run_list": [ "recipe[mybb::default]", "recipe[datadog::default]"]
}
