# Let's check which of months is contain 30 days.

# Creating Year/month data.
year = {jan: 31, feb:29, march: 31, apr:30, may: 31, june: 30, july: 31, aug: 31, sep: 30, oct: 31, nov: 30, dec: 31}

# Checking where we have 30ty days months.
year.each { |month, quontity| puts month if quontity == 30}
