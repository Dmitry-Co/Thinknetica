# Here we'll find date year order based on person's input data.

# Request of date, month and year.
puts "Please input date."
date = Integer(gets.chomp)

puts "Please input digital value of month."
month = Integer(gets.chomp)

puts "Please input year."
year = Integer(gets.chomp)

# Create leap year condition.
leap_year = {1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31}

leap_year[2] = 29 if ((year % 4 == 0 && year % 400 == 0) || (year % 4 == 0 && year % 100 != 0))

# Create condition for non correct data input and final outcome.
if (date <= 0 || month <= 0 || year <= 0) || date > 31 || month > 12 || year > 2078 || year < 1900
  puts "Sorry your input is wrong. Please input correct format of data"
else
    serial_number = leap_year.values.take(month - 1).sum + date
    puts "This is #{serial_number}  of #{year} year!"
end