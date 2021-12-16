# sorrry, I'm not interesting in the Math portion of HOW to calculate primes quickly
require 'prime'

module Nth
  refine Enumerable do
    def nth(n, &block)
      drop(n - 1).first
    end
  end
end

class Prime
  using Nth
  def self.primes
    Enumerator.new do |primes|
      # performance optimization so we can skip by 2 later
      primes << 2
      i = 1
      loop do
        primes << i if Prime.prime?(i)
        i += 2
      end
    end.lazy
  end

  def self.nth(n)
    raise ArgumentError if n.zero?

    primes.nth(n)
  end
end