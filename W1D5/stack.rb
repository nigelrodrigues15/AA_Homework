class Stack
  attr_accessor :stack_array

  def initialize
    @stack_array = []
  end

  def push(el)
    # adds an element to the stack
    stack_array.push (el)
    el
  end

  def pop
    # removes one element from the stack
    stack_array.pop
  end

  def peek
    # returns, but doesn't remove, the top element in the stack
    stack_array.last
  end

end

# Test
arr = Stack.new
p arr.push(3)
p arr.push(4)
p arr.pop
p arr.stack_array
