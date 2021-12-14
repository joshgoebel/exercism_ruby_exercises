class Deque
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  # adds to head
  def push(value)
    node = Node.new(value, next: head)
    head&.previous = node
    @head = node
    @tail = head if was_empty?
  end

  # pulls form head
  def pop
    head.data.tap do
      @head = head.next
      @tail = nil if head.nil?
    end
  end

  # pulls from tail
  def shift
    tail.data.tap do
      @tail = tail.previous
      @head = nil if tail.nil?
    end
  end

  # adds to tail
  def unshift(value)
    node = Node.new(value, previous: tail)
    tail&.next = node
    @tail = node
    @head = tail if was_empty?
  end

  private

  def was_empty?
    head.nil? || tail.nil?
  end

end

class Node
  attr_accessor :next, :previous, :data

  def initialize(data, **args)
    @data = data
    @next = args[:next]
    @previous = args[:previous]
  end
end
