require 'singleton'

class Singleton
  include Singleton

  attr_accessor :data

  def initialize
    @data = "This is the singleton instance"
  end
end

# Спроба створення нового екземпляра викличе помилку
# singleton_instance = SingletonClassExample.new  
# Помилка: private method `new' called 
# for SingletonClassExample:Class (NoMethodError)

# Отримання єдиного екземпляра
singleton_instance = Singleton.instance

# Використання єдиного екземпляра
puts singleton_instance.data  # Виведе "This is the singleton instance"

# Зміна даних в єдиному екземплярі
singleton_instance.data = "Updated data"

# Використання змінених даних
puts singleton_instance.data  # Виведе "Updated data"