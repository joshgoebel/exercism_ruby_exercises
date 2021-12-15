class BaseConverter
  def self.convert(*args)
    BaseConverter.new.convert(*args)
  end

  def convert(input_base, digits, output_base)
    assert_valid_base!(input_base)
    assert_valid_base!(output_base)
    assert_valid_digits!(digits, input_base)

    value = to_base10(digits, base: input_base)
    to(value, base: output_base)
  end

  private

  def to_base10(digits, base:)
    digits.reverse.map.with_index {|digit, i| digit * (base ** i) }.sum
  end

  def to(value, base:)
    digits = []
    loop do
      remainder = value % base

      digits.unshift(remainder)
      value /= base
      break if value.zero?
    end
    digits
  end

  def assert_valid_base!(base)
    raise ArgumentError, "#{base} is not a valid base" if base < 2
  end

  def assert_valid_digits!(digits, input_base)
    raise ArgumentError if digits.any?(&:negative?)
    raise ArgumentError if digits.any? { |d| d >= input_base }
  end

end