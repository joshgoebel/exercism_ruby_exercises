# Sieve.new(1).primes

class Sieve
  def initialize(maximum)
    @maximum = maximum
  end

  def primes
    self.sieve = start_sieve
    i = 1

    while i < maximum
      i = next_prime(i)
      break unless i

      mark_multiples_of(i)
    end
    unmarked
  ensure
    self.sieve = nil
  end

  private

  attr_reader :maximum
  attr_accessor :sieve

  # everything non-nil
  def unmarked
    sieve.compact
  end

  def next_prime(i)
    ((i + 1)...maximum).find { |el| unmarked?(el) }
  end

  def mark_multiples_of(multiple)
    # skip the multiple itself
    # ie, 2 is prime, 4, 6, 8 are not
    start = multiple + multiple
    (start..maximum).step(multiple, &method(:mark!))
  end

  def mark!(p)
    sieve[p] = nil
  end

  def unmarked?(p)
    !sieve[p].nil?
  end

  def start_sieve
    sieve = Array.new(maximum + 1, &proc { |i| i })
    sieve[0] = sieve[1] = nil
    sieve
  end
end