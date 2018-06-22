class Queue
attr_accessor :queue_array

  def initialize
    @queue_array = []
  end

  def enqueue(el)
    queue_array.push(el)
    el
  end

  def dequeue
    queue_array.shift
  end

  def peek
    queue_array.first
  end

end

# Test
arr = Queue.new
p arr.enqueue(3)
p arr.enqueue(4)
p arr.dequeue
p arr.queue_array
