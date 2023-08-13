# We're in the mall. Let's to buy something.

# Input hash and array variables.
purchases = {}
total_price = []

# Request of date, month and year in loop.
loop do |arg|

puts "Please input product name."
product = String(gets.chomp)

break if product == "stop"  

puts "Please input price for the one piece of product."
price = Float(gets.chomp)

puts "Please input quantity of products."
quantity = Float(gets.chomp)   

# Create condition for non correct data input & assining {} purchases.
if product.empty? || quantity <= 0 || price <= 0
    puts "Sorry your input is wrong. Please input correct format of data"
  else
    purchases[product.to_sym] = {price_product: price, products_quantity: quantity}
  end
end

# Counting price of each products and total price.
purchases.each do |product, amount|
    product_sum = (amount[:price_product] * amount[:products_quantity]).round(2)
    total_price  << product_sum
    puts "#{product}: #{amount}, summary for products: #{product_sum}"
  end
  
  puts "Total price is #{total_price.sum}!"