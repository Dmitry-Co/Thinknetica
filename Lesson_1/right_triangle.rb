# Right triangle calculation.

# Asking three different sides values and assigning it to variables.
puts "Please input side a"
a = Integer(gets.chomp)

puts "Please input side b"
b = Integer(gets.chomp)

puts "Please input side c"
c = Integer(gets.chomp)

# Calculation.
if a == b && b == c
    puts "You've got isosceles and equilateral triangle!"
  else
    outcome = "Right triangle"
    if a > b && a > c
      decision = b**2 + c**2
      if decision == a**2
        puts outcome
        if b == c
          puts "#{outcome} and isosceles triangle!"
        end
      else
        puts "Wrong triangle"
      end
    elsif b > a && b > c
      decision = a**2 + c**2
      if decision == b**2
        puts outcome
        if a == c
          puts "#{outcome} and isosceles triangle!"
        end
      else
        puts "You've got wrong triangle!"
      end
    else
      c > a && c > b
      decision = a**2 + b**2
      if decision == c**2
        puts outcome
        if a == b
          puts "#{outcome} and isosceles triangle!"
        end
      else
        puts "You've got wrong triangle!"
      end
    end
  end