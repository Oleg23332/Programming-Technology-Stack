require 'json'
require 'date'

class Task
  attr_accessor :title, :deadline, :status

  def initialize(title, deadline, status = "incomplete")
    @title = title
    @deadline = Date.parse(deadline)
    @status = status
  end

  def to_hash
    { title: @title, deadline: @deadline.to_s, status: @status }
  end
end

class TaskManager
  FILE_NAME = "tasks.json"

  def initialize
    @tasks = load_tasks
  end

  def add_task(title, deadline)
    task = Task.new(title, deadline)
    @tasks << task
    save_tasks
    task
  end

  def delete_task(title)
    @tasks.reject! { |task| task.title == title }
    save_tasks
  end

  def edit_task(title, new_title: nil, new_deadline: nil, new_status: nil)
    task = @tasks.find { |t| t.title == title }
    if task
      task.title = new_title if new_title
      task.deadline = Date.parse(new_deadline) if new_deadline
      task.status = new_status if new_status
      save_tasks
      task
    else
      nil
    end
  end

  def filter_tasks(status: nil, due_date: nil)
    filtered_tasks = @tasks
    filtered_tasks = filtered_tasks.select { |t| t.status == status } if status
    filtered_tasks = filtered_tasks.select { |t| t.deadline <= Date.parse(due_date) } if due_date
    filtered_tasks
  end

  private

  def load_tasks
    return [] unless File.exist?(FILE_NAME)

    JSON.parse(File.read(FILE_NAME), symbolize_names: true).map do |task_data|
      Task.new(task_data[:title], task_data[:deadline], task_data[:status])
    end
  end

  def save_tasks
    data = @tasks.map(&:to_hash)
    File.write(FILE_NAME, JSON.pretty_generate(data))
  end
end

class TaskApp
  def initialize
    @task_manager = TaskManager.new
  end

  def run
    loop do
      puts "\n--- Task Manager ---"
      puts "1. Add Task"
      puts "2. Delete Task"
      puts "3. Edit Task"
      puts "4. View Tasks"
      puts "5. Filter Tasks"
      puts "6. Exit"
      print "Choose an option: "
      case gets.chomp
      when "1"
        add_task
      when "2"
        delete_task
      when "3"
        edit_task
      when "4"
        view_tasks
      when "5"
        filter_tasks
      when "6"
        break
      else
        puts "Invalid option!"
      end
    end
  end

  private

  def add_task
    print "Enter task title: "
    title = gets.chomp
    print "Enter task deadline (YYYY-MM-DD): "
    deadline = gets.chomp
    @task_manager.add_task(title, deadline)
    puts "Task added successfully!"
  end

  def delete_task
    print "Enter the title of the task to delete: "
    title = gets.chomp
    @task_manager.delete_task(title)
    puts "Task deleted successfully!"
  end

  def edit_task
    print "Enter the title of the task to edit: "
    title = gets.chomp
    print "New title (leave blank to keep current): "
    new_title = gets.chomp
    print "New deadline (YYYY-MM-DD, leave blank to keep current): "
    new_deadline = gets.chomp
    print "New status (complete/incomplete, leave blank to keep current): "
    new_status = gets.chomp
    @task_manager.edit_task(title, new_title: new_title.presence, new_deadline: new_deadline.presence, new_status: new_status.presence)
    puts "Task updated successfully!"
  end

  def view_tasks
    tasks = @task_manager.filter_tasks
    display_tasks(tasks)
  end

  def filter_tasks
    print "Enter status to filter (complete/incomplete or leave blank): "
    status = gets.chomp
    print "Enter due date to filter (YYYY-MM-DD or leave blank): "
    due_date = gets.chomp
    tasks = @task_manager.filter_tasks(status: status.presence, due_date: due_date.presence)
    display_tasks(tasks)
  end

  def display_tasks(tasks)
    tasks.each do |task|
      puts "#{task.title} | Deadline: #{task.deadline} | Status: #{task.status}"
    end
  end
end

#TaskApp.new.run
