# for slicing and dicing
class Slicer
  class InvalidSliceLengthError < ArgumentError; end

  def initialize(digits)
    @digits = digits
  end

  def slices(length)
    # raise InvalidSliceLengthError if length > digits.size
    raise InvalidSliceLengthError unless (1..digits.size).cover?(length)

    # digits.each_char.each_cons(length).map(&:join)
    # digits
    #   .length
    #   .then { |max| 0..max - slice_length }
    #   .map { |start| digits.slice(start, slice_length) }
    digits
      .then { slice_indexes(length) }
      .map { |index| digits.slice(*index) }
  end

  private

  def slice_indexes(length)
    (0...number_of_slices(length))
      .map { |offset| [offset, length] }
  end

  def number_of_slices(length)
    digits.size - length + 1
  end

  attr_reader :digits
end
Series = Slicer