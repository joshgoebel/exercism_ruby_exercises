class Series
  def initialize(digits)
    @digits = digits
  end

  def largest_product(size)
    raise ArgumentError if size.negative?
    raise ArgumentError unless valid_digits?
    raise ArgumentError if size > @digits.length
    return 1 if @digits.length.zero? || size.zero?

    @digits
      .each_char
      .map(&:to_i)
      .each_cons(size)
      .map { |list| list.inject(&:*) }
      .max
  end

  private

  def valid_digits?
    @digits.match(/^\d*$/)
  end
end