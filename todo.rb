# Classes

class List
  attr_reader :all_tasks

  def initialize()
    @all_tasks = []
  end

  public
  def add(task)
    all_tasks << task
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
  puts "You've added a task to the list!"
end