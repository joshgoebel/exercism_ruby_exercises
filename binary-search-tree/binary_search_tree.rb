class Bst
  include Enumerable

  attr_accessor :data, :left, :right

  def initialize(data = nil)
    @data = data
  end

  def each(&block)
    return to_enum unless block_given?

    left&.each(&block)
    yield data
    right&.each(&block)
  end

  def insert(insertion_data)
    dir = insertion_data <= data ? :left : :right
    _insert(dir, insertion_data)
  end

  private

  def _insert(where, data)
    if self[where].nil?
      send("#{where}=", Bst.new(data))
    else
      self["#{where}"].insert(data)
    end
  end
  def [](x)
    send(x)
  end

  def insert_left(data)
    if left.nil?
      self.left = Bst.new(data)
    else
      left.insert(data)
    end
  end

  def insert_right(data)
    if right.nil?
      self.right = Bst.new(data)
    else
      right.insert(data)
    end
  end
end
