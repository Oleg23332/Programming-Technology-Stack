
OPTIONS = ['бумага', 'камень', 'ножницы']

# Функція для визначення переможця
def winner(player, bot)
  if player == bot
  puts "Нічия!"
  elsif (player == 'камень' && bot == 'ножницы') ||
        (player == 'ножницы' && bot == 'бумага') ||
        (player == 'бумага' && bot == 'камень')
    "Ви виграли!"
  else
    "Комп'ютер виграв!"
  end
end

# Основна частина гри
loop do
  puts "Оберіть камень, ножницы або бумага:"
  player_ch = gets.chomp.strip.downcase

  # Перевірка, чи правильний вибір
  unless OPTIONS.include?(player_ch)
    puts "Неправильний вибір, спробуйте ще раз."
    next
  end

  # Випадковий вибір комп'ютера
  bot_ch = OPTIONS.sample
  puts "Комп'ютер обрав: #{bot_ch}"

  # Визначення результату
  res = winner(player_ch, bot_ch)
  puts res

  # Запитати, чи хоче гравець зіграти ще раз
  puts "Грати ще раз? (так/ні)"
  answer = gets.chomp.strip.downcase
  break unless answer == 'так'
end

puts "Дякуємо за гру!"
