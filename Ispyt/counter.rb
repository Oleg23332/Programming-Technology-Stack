def count_characters(input)
  counts = Hash.new(0)
  input.each_char { |char| counts[char] += 1 }
  counts
end

puts "Введіть рядок:"
user_input = gets.chomp
result = count_characters(user_input)

puts "Кількість символів у рядку:"
result.each { |char, count| puts "#{char.inspect}: #{count}" }