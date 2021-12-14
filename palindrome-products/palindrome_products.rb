# frozen_string_literal: true

# stores palindrome result and related factors
class PalindromeResult
  attr_reader :value
  attr_reader :factors

  def initialize(value, factors)
    @value = value
    @factors = factors
  end
end

# generates min and max palindromes for a given range
class Palindromes

  attr_reader :largest
  attr_reader :smallest

  def initialize(min_factor: 1, max_factor: nil)
    @min_factor = min_factor
    @max_factor = max_factor
    @factor_cache = Hash.new { |h, k| h[k] = [] }
  end

  def generate
    # .select {|a,b| palindrome?(a * b) ? @factor_cache[a*b] << [a,b] : false }
    min, max = minmax_products
    @smallest = PalindromeResult.new(min, factors_for(min))
    @largest = PalindromeResult.new(max, factors_for(max))
  end

  private

  def combos
    (min_factor..max_factor).to_a \
      .repeated_combination(2)
  end

  def minmax_products
    combos
      .select { |a, b| palindrome?(a * b) }
      .each { |a, b| @factor_cache[a * b] << [a, b] }
      .map { |a, b| a * b }
      .minmax
  end

  def factors_for(value)
    # combos.select {|a,b| a * b == value }
    @factor_cache[value]
  end

  def palindrome?(num)
    # faster than to_s to to_s comparison
    num == num.to_s.reverse.to_i
  end

  attr_reader :min_factor, :max_factor

end
