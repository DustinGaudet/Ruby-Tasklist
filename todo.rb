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
end

class Task 
  attr_reader :description

  def initialize(description)
    @description = description
  end
end

if __FILE__ == $PROGRAM_NAME
  list_1 = List.new
  puts "New list created!"
  list_1.add(Task.new("Walk the dog."))
  list_1.add(Task.new("Walk the cat."))
  list_1.add(Task.new("Walk the bear."))
  puts "You've added 3 tasks to the list!"
  list_1.show_tasks
end