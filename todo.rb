# Classes

class List; end
class Task 
  attr_reader :description

  def initialize(description)
    @description = description
  end
end

if __FILE__ == $PROGRAM_NAME
  list_1 = List.new
  puts "New list created!"
end