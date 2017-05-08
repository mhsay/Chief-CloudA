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
        "dbuser": "dbadmin",
        "dbpass": "q1w2e3r3"
    },
  "run_list": [ "recipe[mybb::default]" ]
}