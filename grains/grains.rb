# constant time solutions
class Grains
  VALID_SQUARES = 1..64
  private_constant :VALID_SQUARES

  def self.square(n)
    raise ArgumentError, "must be in range 1 .. 64" unless VALID_SQUARES.cover?(n)

    2 ** (n-1)
  end

  def self.total
    2 ** VALID_SQUARES.max - 1
  end
end