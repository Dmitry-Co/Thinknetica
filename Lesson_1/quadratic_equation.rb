# Quadratic equation calculation.

puts "Hello! 
We are going to calculate the quadratic equation."

# Asking three different coefficients and assigning it to variables.
puts "Please input 1st coefficient."
a = Integer(gets.chomp)

puts "Please input 2st coefficient."
b = Integer(gets.chomp)

puts "Please input 3st coefficient."
c = Integer(gets.chomp)



# Calculation.
  d = (b**2) - (4*a*c)
  C = Math.sqrt(d)
   if d < 0
    puts "We have no roots because discriminant is equal #{d}"
   else
    if d > 0
        x1 = (-b + C) / (2*a)
        x2 = (-b - C) / (2*a)
        puts "Discriminant outcome is #{d}."
        puts "Roots calculation are: 
           x1 = #{x1.round(3)} 
           x2 = #{x2.round(3)}"
    else
       x = -b / (2*a)
       puts "Our x1 and x2 roots are equal #{x} because discriminant is #{d}." 
    end
   end