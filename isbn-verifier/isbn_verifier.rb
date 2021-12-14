class IsbnVerifier
  ISBN_DIGIT = /[0-9X]/.freeze
  VALID_ISBN = /^(\d-?){9}#{ISBN_DIGIT}$/.freeze
  CHECKSUMS = 10.downto(1).to_a

  def self.valid?(number)
    new(number).valid?
  end

  def valid?
    return false unless valid_isbn_format?

    (checksum % 11).zero?
  end

  private

  attr_reader :number

  def initialize(number)
    @number = number
  end

  def checksum
    number
      .scan(ISBN_DIGIT)
      .map(&method(:digit_value))
      .zip(CHECKSUMS)
      .sum { |digit, check| digit * check }
  end

  def valid_isbn_format?
    number.match? VALID_ISBN
  end

  def digit_value(c)
    c == "X" ? 10 : c.to_i
  end
end
