# Sieve.new(1).primes

class Sieve
  def initialize(maximum)
    @maximum = maximum
  end

  def primes
    @sieve = start_sieve
    i = 1

    while i <= maximum
      i = next_prime(i)
      break unless i

      mark_multiples_of(i)
    end
    sieve.compact
  ensure
    @sieve = nil
  end

  private

  attr_reader :maximum, :sieve

  def next_prime(i)
    ((i + 1)..maximum).find { |el| !sieve[el].nil? }
  end

  def mark_multiples_of(multiple)
    # skip the multiple itself
    # ie, 2 is prime, 4, 6, 8 are not
    start = multiple + multiple
    (start..maximum).step(multiple) do |p|
      sieve[p] = nil
    end
  end

  def start_sieve
    sieve = Array.new(maximum + 1, &proc { |i| i })
    sieve[0] = sieve[1] = nil
    sieve
  end
end