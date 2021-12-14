class SumOfMultiples
  def initialize(*multiples)
    @multiples = multiples
  end

  def to(max)
    @multiples.flat_map do |multiple|
      next [] if multiple.zero?
      # just find all the multiples of each multiple up to max
      (multiple...max).step(multiple).to_a
    end.uniq.sum
  end
end