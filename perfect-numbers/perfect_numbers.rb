class PerfectNumber
  def self.classify(n)
    raise "negatives not allowed" if n.negative?

    aliquot_sum = multiples_of(n).sum

    if aliquot_sum < n
      "deficient"
    elsif aliquot_sum > n
      "abundant"
    else
      "perfect"
    end
  end
  def self.multiples_of(num)
    (1...num).select { |n| (num % n).zero? }
  end
end
