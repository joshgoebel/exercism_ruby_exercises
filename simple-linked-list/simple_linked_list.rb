class SimpleLinkedList
  include Enumerable

  attr_reader :head

  def initialize(array = [])
    @head = nil
    init_from(array)
  end

  def push(node)
    node.next = head if head
    @head = node
    self
  end

  def pop
    # I wonder if the &.next is too hidden?
    # return nil if head.nil?

    head.tap { @head = head&.next }
  end

  def each
    each_node { |node| yield node.datum }
  end

  def reverse!
    tmp = SimpleLinkedList.new
    each_node do |x|
      x.next = nil
      tmp.push x
    end
    @head = tmp.head
    self
    # el = @head
    # last = nil
    # while el
    #   nxt = el.next
    #   el.next = last
    #   last = el
    #   el = nxt
    # end
    # @head = last
    # self
  end

  private

  def each_node
    node = head
    while node
      # we preserve nxt here out of fear that the yield might change it
      # as is actually the case with reverse!
      nxt = node.next
      yield node
      node = nxt
    end
  end

  def init_from(array)
    array.each { |x| push Node.new(x) }
  end
end

class Node
  attr_reader :datum
  attr_accessor :next

  def initialize(data)
    @datum = data
  end
end
Element = Node