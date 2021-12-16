# sorrry, I'm not interesting in the Math portion of HOW to calculate primes quickly
require 'prime'

class Prime
  def self.nth(n)
    raise ArgumentError if n.zero?

    (2..).lazy
    .select(&Prime.method(:prime?))
    .drop(n-1).first
  end
end