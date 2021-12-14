class Darts

  DISTANCE_to_SCORE = {
    0..1 => 10,
    1..5 => 5,
    5..10 => 1,
    10..Float::INFINITY => 0
  }

  def initialize(x, y)
    @x = x
    @y = y
  end

  def score
    shot_distance = vector_to_distance([x,y])
    DISTANCE_to_SCORE.find { |distance, score| distance.cover?(shot_distance) }[1]
  end

  private
  attr_reader :x, :y

  def vector_to_distance(vector)
    x, y = vector.map(&:abs)
    Math.sqrt(x*x + y*y)
  end
end