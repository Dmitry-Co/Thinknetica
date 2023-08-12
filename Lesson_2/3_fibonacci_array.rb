# Fibonacci array up to 100.

# Creating variables.     
index = 0
num = [0, 1]

# Creating fibo with conditions. 
while (new = num[index] + num[index + 1]) < 100 do
  num.push new
  index += 1
end

print num