require 'rspec'
require_relative 'task_manager'

RSpec.describe TaskManager do
  let(:task_manager) { TaskManager.new }

  before do
    File.delete(TaskManager::FILE_NAME) if File.exist?(TaskManager::FILE_NAME)
  end

  after do
    File.delete(TaskManager::FILE_NAME) if File.exist?(TaskManager::FILE_NAME)
  end

  describe '#add_task' do
    it "adds a new task to the task list" do
      task_manager.add_task("Test Task", "2024-12-31")
      expect(task_manager.filter_tasks.map(&:title)).to include("Test Task")
    end
  end

  describe '#delete_task' do
    it 'deletes a task by title' do
      task_manager.add_task("Task to Delete", "2024-12-31")
      task_manager.delete_task("Task to Delete")
      expect(task_manager.filter_tasks.map(&:title)).not_to include("Task to Delete")
    end
  end

  describe '#edit_task' do
    it 'edits an existing task' do
      task_manager.add_task("Task to Edit", "2024-12-31")
      task_manager.edit_task("Task to Edit", new_title: "Edited Task", new_status: "complete")
      task = task_manager.filter_tasks.find { |t| t.title == "Edited Task" }
      expect(task).not_to be_nil
      expect(task.status).to eq("complete")
    end
  end

  describe '#filter_tasks' do
    it 'filters tasks by status' do
      task_manager.add_task("Incomplete Task", "2024-12-31")
      task_manager.add_task("Complete Task", "2024-12-31")
      task_manager.edit_task("Complete Task", new_status: "complete")
      filtered_tasks = task_manager.filter_tasks(status: "complete")
      expect(filtered_tasks.map(&:title)).to eq(["Complete Task"])
    end

    it 'filters tasks by due date' do
      task_manager.add_task("Past Task", "2024-01-01")
      task_manager.add_task("Future Task", "2024-12-31")
      filtered_tasks = task_manager.filter_tasks(due_date: "2024-06-01")
      expect(filtered_tasks.map(&:title)).to eq(["Past Task"])
    end
  end
end
