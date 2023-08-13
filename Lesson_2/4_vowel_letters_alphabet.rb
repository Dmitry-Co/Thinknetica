# We are going to order only vowels to alphabet.

# Dataset.
vowels = %w[A E I O U Y]
new = {}

# Firstly indexing our alphabet and after checkout vowels for presences.
('A'..'Z').each.with_index(1) {|vowel, index| new[vowel.to_sym] = index if vowels.include?(vowel)}

puts new