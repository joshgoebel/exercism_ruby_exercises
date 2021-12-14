class Triangle

  attr_reader :sides

  def initialize(sides)
    @sides = sides
  end

  def equilateral?
    legal? && equal_sides == 3
  end

  def isosceles?
    legal? && equal_sides >= 2
  end

  def scalene?
    legal? && equal_sides.zero?
  end

  private

  def legal?
    return false if sides.any?(&:zero?)
    return false unless has_three_sides?
    return false unless passes_triangle_inequality?

    true
  end

  def has_three_sides?
    sides.size == 3
  end

  # https://en.wikipedia.org/wiki/Triangle_inequality
  def passes_triangle_inequality?
    a, b, c = sides.sort
    a + b >= c
  end

  def equal_sides
    uniq = sides.uniq.size
    return 0 if uniq == 3
    4 - uniq
  end

end