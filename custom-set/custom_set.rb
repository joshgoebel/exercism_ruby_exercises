class CustomSet
  def initialize(array=[])
    @hash = {}
    array.each(&method(:add))
  end

  def empty?
    storage.empty?
  end

  def member?(value)
    storage.member?(value)
  end

  alias include? member?

  def subset?(b)
    values.all?(&b.method(:member?))
  end

  def disjoint?(b)
    values.none?(&b.method(:member?))
  end

  def intersection(b)
    # values & b.values
    values.select(&b.method(:member?))
  end

  def difference(b)
    # values - b.values
    values.reject(&b.method(:member?))
  end

  def union(b)
    CustomSet.new.tap do |union|
      union.storage
        .merge!(storage)
        .merge!(b.storage)
    end
  end

  def add(value)
    storage[value] = true
    self
  end

  def to_a
    storage.keys
  end

  def values
    to_a
  end

  def ==(b)
    # to_a here allows duck typing, comparing an Array, etc.
    values.sort == b.to_a.sort
  end

  alias eql? :==

  protected

  def storage
    @hash
  end

end
