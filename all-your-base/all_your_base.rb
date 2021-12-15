class BaseConverter
  def self.convert(input_base, digits, output_base)
    raise ArgumentError if input_base < 2
    raise ArgumentError if output_base < 2
    raise ArgumentError if digits.any?(&:negative?)
    raise ArgumentError if digits.any? {|d| d >= input_base }

    value = to_base_10(digits, from: input_base)
    to(value, base: output_base)
  end
  def self.to_base_10(digits, from:)
    base = from
    digits.reverse.map.with_index {|digit, i| digit * (base ** i) }.sum
  end
  def self.to(value, base:)
    digits = []
    while value > 0
      remainder = value % base

      digits << remainder
      value /= base
    end
    digits.empty? ? [0] : digits.reverse
  end
end