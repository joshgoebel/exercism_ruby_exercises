class Luhn

  def self.valid?(number)
    Luhn.new(number).valid?
  end

  def initialize(number)
    @number = remove_spaces(number)
  end

  def valid?
    return false if too_short?
    return false if has_invalid_chars?

    divisible_by?(10,checksum)
  end

  private

  attr_reader :number

  def divisible_by?(divisor, number)
    (number % divisor).zero?
  end

  def checksum
    double_every_second_digit(digits).sum()
  end

  def double_every_second_digit(digits)
    digits.each_slice(2).map do |even, odd = 0|
      even + double(odd)
    end
  end

  def digits
    number.to_i.digits
  end

  def double(digit)
    digit *= 2
    # but make sure our result is still 0-9
    digit -= 9 if digit >= 10
    digit
  end

  def remove_spaces(s)
    s.delete(" ")
  end

  def has_invalid_chars?
    number.scan(/\D/).any?
  end

  def too_short?
    number.size <= 1
  end

end
