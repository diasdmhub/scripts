#!/usr/bin/env python
"""
zabbix_sla.py: Script to fetch SLI values from a Zabbix specific SLA
"""
__author__ = "diasdm"

# -- Project information -----------------------------------------------------

# A script to retrieve SLI values from a specific SLA in Zabbix.
# The script displays a list of SLIs found, sorted by to the number of periods.
# The bottom value is the most recent one, usually for the current period.

# Zabbix-Utils documentation - https://pypi.org/project/zabbix-utils
# Zabbix-Utils GitHub        - https://github.com/zabbix/python-zabbix-utils
# Zabbix-Utils blog post     - https://blog.zabbix.com/python-zabbix-utils/27056
# Zabbix API reference       - https://www.zabbix.com/documentation/current/en/manual/api/reference
# Zabbix API Method          - https://www.zabbix.com/documentation/current/en/manual/api/reference/sla/getsli

# -- Project information -----------------------------------------------------

# Zabbix library import
from zabbix_utils import ZabbixAPI
from datetime import datetime
import calendar
import argparse


# Create an argument parser
parser = argparse.ArgumentParser(description='Script to fetch SLI values from Zabbix')

# Add arguments ## Period 1 is always the most recent one
parser.add_argument('--zabbixURL', type=str, required=True, help='URL of the Zabbix Server')
parser.add_argument('--zabbixToken', type=str, required=True, help='API token for accessing Zabbix')
parser.add_argument('--slaid', type=int, required=True, help='SLA ID from the Zabbix SLA to fetch SLI values')
parser.add_argument('--periods', type=int, default=1, help='Number of periods to fetch SLI values for')

# Parse the arguments
args = parser.parse_args()

# Extract values from arguments
zabbixURL = args.zabbixURL
zabbixToken = args.zabbixToken
slaid = args.slaid
periods = args.periods


# Time variables
nowTimeStamp = int(datetime.now().timestamp())
current_month = datetime.now().month


# Open connection to Zabbix API
api = ZabbixAPI(
    url=zabbixURL,
    token=zabbixToken
)

# Fetch Zabbix SLIs from provided SLA ID
dict = api.sla.getsli(
    slaid=slaid,
    periods=periods
)


# Get month names and calculate previous months based on the number of elements in the "sli" list
previous_months = [(current_month - i - 1) % 12 + 1 for i in range(len(dict["sli"]))]
month_names = [calendar.month_name[month] for month in reversed(previous_months)]


# Print the SLI values according to each month
for month,sli_list in zip(month_names, dict["sli"]):
    for sli_item in sli_list:
        formatted_sli = "{:.2f}".format(sli_item['sli'])
        print(f"{month} SLI: {formatted_sli}")


#for sli_list in object["sli"]:
#    for sli_item in sli_list:
#        print("SLI:", sli_item["sli"])

# api.logout() # not necessary if using a token
