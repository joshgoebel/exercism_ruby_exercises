class CollatzConjecture
  def self.steps(n)
    raise ArgumentError, "cannot be zero" if n.zero?
    raise ArgumentError, "cannot be negative" if n.negative?

    steps = 0

    while n != 1
      if n.even?
        n /= 2
      else # odd
        n = 3 * n + 1
      end
      steps += 1
    end
    steps
  end
end