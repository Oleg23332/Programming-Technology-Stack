
def precedence(op)        # Функція для визначення пріоритету операторів
  case op
  when '+', '-'
    return 1
  when '*', '/'
    return 2
  else
    return 0
  end
end


def operator?(char)           # Функція для перевірки чи символ є оператором
  ['+', '-', '*', '/'].include?(char)
end


def rpn(expression)         # Функція для перетворення інфіксного запису у зворотний польський запис (RPN)
  output = []
  operators = []

  # Проходимо по кожному символу виразу
  expression.each_char do |char|
    if char =~ /\d/ # Якщо символ — число
      output.push(char)
    elsif char == '(' # Якщо це відкрита дужка
      operators.push(char)
    elsif char == ')' # Якщо це закрита дужка
      while operators.any? && operators.last != '('
        output.push(operators.pop)
      end
      operators.pop if operators.any?
    elsif operator?(char) # Якщо це оператор
      while operators.any? && precedence(operators.last) >= precedence(char)
        output.push(operators.pop)
      end
      operators.push(char)
    end
  end

  # Виводимо всі оператори, що залишилися у стеку
  while !operators.empty?
    output.push(operators.pop)
  end

  output.join(' ')
end

puts "Введіть математичний вираз:"
input = gets.chomp
res = rpn(input)
puts "Зворотний польський запис: #{res}"
