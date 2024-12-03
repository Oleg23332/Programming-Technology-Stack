# Метод для позначення нарізаних шматків торта
def cut(ar_cake, x, y, width, height)
  # Проходимося по кожному рядку та стовпчику в межах вказаних координат
  (y...(y + height)).each do |i|
    (x...(x + width)).each { |j| ar_cake[i][j] = "*" } # Позначаємо нарізані частини символом "*"
  end
  ar_cake # Повертаємо оновлений масив торта
end

# Перетворення масиву (який містить рядки) у текстовий формат
def arr_to_string(rectangle_form)
  result = ""
  # Об'єднуємо всі символи в рядок і додаємо перенесення рядка
  rectangle_form.each do |i|
    i.each { |j| result += j }
    result += "\n"
  end
  result # Повертаємо рядок
end

# Метод повертає координати першої доступної (не нарізаної) точки торта
def find_first_not_cut_spot(ar_cake)
  # Перевіряємо кожен елемент у масиві
  (0...ar_cake.size).each do |i|
    (0...ar_cake[i].size).each { |j| return { y: i, x: j } if ar_cake[i][j] != "*" } # Якщо елемент не дорівнює "*", повертаємо його координати
  end
  nil # Повертаємо nil, якщо всі частини вже нарізані
end

# Метод перевіряє, чи можна вирізати шматок торта
def slice_valid(ar_cake, x, y, width, height)
  # Перевіряємо, чи виходить шматок за межі торта
  return nil if (x + width) > ar_cake[0].size || (y + height) > ar_cake.size

  # Вирізаємо підмасив, що відповідає шматку торта
  slice = ar_cake.slice(y, height) # Вибір рядків
  slice = slice.map { |i| i.slice(x, width) } # Вибір стовпців
  str_slice = arr_to_string(slice) # Перетворюємо підмасив у рядок
  # Рядок є недійсним, якщо містить символ "*" або має більше/менше одного родзинка
  return nil if str_slice.include?("*") || str_slice.count("o") != 1

  str_slice # Повертаємо шматок торта у вигляді рядка
end

# Рекурсивний метод для розрізання торта
def searching(ar_cake, slices, size)
  # Знаходимо першу доступну позицію
  position = find_first_not_cut_spot(ar_cake)
  return slices if position.nil? # Якщо немає доступних позицій, повертаємо нарізані шматки

  # Починаємо з максимально можливої ширини шматка
  slice_width = size
  loop do
    break if slice_width == 0
    slice_height = 0
    loop do
      break if slice_height == size
      slice_height += 1
      next unless slice_width * slice_height == size # Усі шматки мають бути однакової площі
      slice = slice_valid(ar_cake, position[:x], position[:y], slice_width, slice_height)
      next if slice.nil?

      # Копіюємо масиви, щоб уникнути змін оригінальних даних
      new_slices = slices.dup
      new_slices.push(slice)
      new_ar_cake = ar_cake.map(&:dup)

      # Оновлюємо торт із вирізаним шматком
      new_ar_cake = cut(new_ar_cake, position[:x], position[:y], slice_width, slice_height)

      # Рекурсивно шукаємо наступні шматки
      res = searching(new_ar_cake, new_slices, size)
      return res if res.size > 0
    end
    slice_width -= 1
  end
  [] # Повертаємо порожній масив, якщо розрізання неможливе
end

# Перевірка правильності форми торта і кількості родзинок
def cake_valid?(cake)
  return false if cake.count("o") <= 1 || cake.count("o") >= 10
  array_cake = cake.split("\n")
  cake_width = array_cake[0].size
  array_cake.each do |i|
    return false unless i.size == cake_width # Усі рядки мають бути однакової довжини
  end
  true
end

cake = ".o......\n...o....\n....o...\n........\n.....o..\n........" # Початковий приклад торта

puts "cake =\n#{cake}"
puts "Примітка: Якщо ваш торт виглядає неправильно, переконайтеся, що ви використовуєте пробіли між рівнями торта."
raisins = cake.count("o")
puts "Кількість родзинок: #{raisins}"

unless cake_valid?(cake)
  puts "Ваш торт має неправильну форму (не прямокутник) або кількість родзинок поза діапазоном (1;10)."
  exit
end

puts "Пробуємо розрізати торт..."
# Перетворюємо торт із рядка в двовимірний масив для зручності обробки
array_cake = cake.split("\n").map { |i| i.split("") }
slice_size = (array_cake.size * array_cake[0].size) / raisins
puts "Бажаний розмір шматків: #{slice_size}"
slices = searching(array_cake, [], slice_size)

if slices.empty?
  puts "Не вдалося правильно розрізати торт."
else
  puts "Результат:"
  slices.each { |i| puts "\n" + i }
end
