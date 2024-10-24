class Student
  def initialize(name, bal)
    @name = name
    @bal = bal
  end

  def average
    total = 0
    count = 0

    @bal.each do |num|
      total += num
      count += 1
    end

    average_score = total.to_f / count
    puts "Студент: #{@name}"D
    puts "Середній бал: #{average_score}"
  end
end

s1 = Student.new("Oleg", [5, 4, 5, 3, 5, 3, 4, 2])
s1.average