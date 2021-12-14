module RomanNumerals
  DECIMAL_to_ROMAN = {
    1000 => "M",
    900 => "CM",
    500 => "D",
    400 => "CD",
    100 => "C",
    90 => "XC",
    50 => "L",
    40 => "XL",
    10 => "X",
    9 => "IX",
    5 => "V",
    4 => "IV",
    1 => "I"
  }

  def to_roman
    value = self
    "".tap do |roman|
      DECIMAL_to_ROMAN.each do |n, numeral|
        if value >= n
          count = value / n
          value -= (n * count)
          roman << numeral * count
        end
        break if value.zero?
      end
    end
  end
end

class Integer
  include RomanNumerals
end