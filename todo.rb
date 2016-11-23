# Modules

module Menu
  def menu
    "Welcome! Please choose an action:
    1) Add
    2) Show
    3) Update
    4) Delete
    5) Toggle Completion Status
    6) Write to File
    7) Read from File
    Q) Quit"
  end
  def show
    menu
  end
end

module Promptable
  def prompt(message="What would you like to do?", symbol=":> ")
    puts message 
    print symbol
    gets.chomp
  end
end
# Classes

class List
  attr_reader :all_tasks

  def initialize
    @all_tasks = []
  end

  public
  def add(task)
    all_tasks << task
  end
  def show_tasks
    task_num = 1
    all_tasks.each do |task| 
      puts task_num.to_s << ") " << task.to_s
      task_num += 1
    end
  end
  def update_task(number, updated_task)
    index = Integer(number) rescue false
    if index
      @all_tasks[index - 1] = updated_task
    else
      puts "That is not an integer."
    end
  end
  def delete_task(number) 
    index = Integer(number) rescue false
    if index
      @all_tasks.delete_at(index - 1)
    else
      puts "That is not an integer."
    end
  end
  def toggle_status(number)
    index = Integer(number) rescue false
    if index
      @all_tasks[index - 1].toggle_status
    else
      puts "That is not an integer."
    end
  end
  def write_to_file(filename)
    machine_format_list = @all_tasks.map(&:to_machine).join("\n")
    IO.write(filename, machine_format_list)
  end
  def read_from_file(filename)
    begin 
      IO.readlines(filename).each do |line|
        task_data = line.split(":")
        task_status = task_data[0].include?("[√]") ? true : false
        task_description = task_data[1].chomp
        add(Task.new(task_description, task_status))
      end
    rescue Errno::ENOENT
      "Sorry, this file doesn't exist."
    end
  end
end

class Task 
  attr_reader :description
  attr_accessor :status

  def initialize(description, status = false)
    @description = description
    @status = status
  end
  def to_s
    "#{description} #{represent_status}"
  end
  def completed?
    status 
  end
  def toggle_status
    @status = !completed?
  end
  def to_machine
    "#{represent_status}:#{description}"
  end

  private
  
  def represent_status
    completed? === true ? "[√]" : "[ ]"
  end
end

if __FILE__ == $PROGRAM_NAME
  include Menu
  include Promptable
  list_1 = List.new
  puts "Please choose an option from this menu."
  until ['q'].include?(user_input = prompt(show).downcase)
    case user_input
    when "1"
      list_1.add(Task.new(prompt("What is your new task?")))
    when "2"
      list_1.show_tasks
    when "3"
      list_1.show_tasks
      list_1.update_task(prompt("Please enter the number of the task to update."), Task.new(prompt("What is your new task?")))
    when "4"
      list_1.show_tasks
      list_1.delete_task(prompt("Please enter the number of the task to delete. \n"))
    when "5"
      list_1.show_tasks
      list_1.toggle_status(prompt("Please enter the number of the task to toggle. \n"))
    when "6"
      list_1.write_to_file(prompt("What should the file be called? (File will be appended with .txt)") << ".txt")
    when "7"
      puts list_1.read_from_file(prompt("What file would you like to read? (_____.txt)") << ".txt")
    else
      puts "I'm sorry, that is an invalid command."
    end
  end
  puts "Thanks for using the task manager!"
end