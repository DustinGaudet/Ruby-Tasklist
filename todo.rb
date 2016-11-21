# Modules

module Menu
  def menu
    "Welcome! Please choose an action:
    1) Add
    2) Show
    3) Write to File
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
  	all_tasks.each do |task| 
  		puts task.description
  	end
  end
  def write_to_file(filename)
    IO.write(filename, @all_tasks.map(&:to_s).join("\n"))
  end
end

class Task 
  attr_reader :description

  def initialize(description)
    @description = description
  end
  def to_s
    description
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
      list_1.write_to_file(prompt("What should the file be called? (File will be appended with .txt)")<<".txt")
    else
      puts "I'm sorry, that is an invalid command."
    end
  end
  puts "Thanks for using the task manager!"
end