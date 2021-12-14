class ListOps
  def self.arrays(list)
    List.new(list).size
  end
  def self.reverser(list)
    List.new(list).reverse
  end
  def self.concatter(list1, list2)
    List.new(list1).concat(list2)
  end
  def self.mapper(list, &block)
    List.new(list).map(&block)
  end
  def self.filterer(list, &block)
    List.new(list).filter(&block)
  end
  def self.sum_reducer(list)
    List.new(list).sum
  end
  def self.factorial_reducer(list)
    List.new(list).inject(1) { |acc, n| acc * n }
  end
end

class List
  def initialize(arr=[])
    @arr = arr
  end

  def inject(start, &block)
    acc = start
    @arr.each do |el|
      acc = yield(acc, el)
    end
    acc
  end

  def each(&block)
    inject(nil) { |_, n| yield(n) }
  end

  def filter(&block)
    inject(List.new) do |acc, n|
      acc << n if yield(n)
      acc
    end
  end

  def map(&block)
    inject(List.new) do |acc, n|
      acc << yield(n)
      acc
    end
  end

  def sum
    inject(0) { |acc, n| acc + n }
  end

  def concat(other)
    List.new.tap do |list|
      each       { |el| list.push(el) }
      other.each { |el| list.push(el) }
    end
  end

  def <<(v)
    push(v)
  end

  def push(v)
    @arr << v
    self
  end

  def empty?
    size == 0
  end

  def size
    i = 0
    # per proof we are allowed to use each,
    # not sure how else to get size
    @arr.each do
      i += 1
    end
    i
  end

  def to_ary
    @arr
  end

  def ==(other)
    @arr == other.to_ary
  end

  # boring
  def reverse
    result = []
    i = size
    while (i>0) do
      result << @arr[i-1]
      i -= 1
    end
    result
  end

  # seemed to be WAY too slow
  # def reverse
  #   _reverse(@arr,[])
  # end

  private

  def _reverse(original, reversed)
    return reversed if original.empty?

    *remaining, last = original
    _reverse(remaining, [*reversed, last])
  end

end
