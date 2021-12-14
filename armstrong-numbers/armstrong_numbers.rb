# An Armstrong number is a number that is the sum of its own digits each raised to the power of the number of digits.
class ArmstrongNumbers
  def self.include?(n)
    number_of_digits = n.digits.size
    sum = n.digits.sum { |digit| digit ** number_of_digits}

    n == sum
  end
end
