# Ideal weight calculation.

puts 'Please input your name'
name = gets.chomp

puts 'Please input your height'
height = Integer(gets.chomp)

ideal_weight = (height - 110) * 1.15
 
puts "#{name} your ideal weight is #{ideal_weight.round(1)} kg!"

if ideal_weight < 0
 puts 'Congrats! You have already an optimal weight!'
end
