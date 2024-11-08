require 'net/http'
require 'json'
require 'csv'

# Ваш API ключ (замініть на свій)
api_key = '14c047494e540f3467b773ca'

# Базова валюта, наприклад, USD
base_currency = 'USD'

# URL для запиту
url = "https://v6.exchangerate-api.com/v6/#{api_key}/latest/#{base_currency}"

# Створюємо запит
uri = URI(url)
response = Net::HTTP.get(uri)

# Парсимо JSON відповідь
data = JSON.parse(response)

# Перевіряємо, чи успішно отримані дані
if data['result'] == 'success'
  # Витягуємо курси валют
  rates = data['conversion_rates']

  # Вказуємо валюти, які нас цікавлять
  currencies = ['EUR', 'USD', 'AED', 'JPY', 'UAH']

  # Записуємо дані у CSV файл
  CSV.open('exchange_rates.csv', 'w') do |csv|
    # Заголовки
    csv << ['Currency', 'Rate']

    # Додаємо курси для вибраних валют
    currencies.each do |currency|
      csv << [currency, rates[currency]]
    end
  end

  puts "Дані збережено у файл exchange_rates.csv"
else
  puts "Не вдалося отримати дані. Помилка: #{data['error-type']}"
end
