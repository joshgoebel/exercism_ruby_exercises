class Raindrops
  PLING_NOISES = {
    3 => "Pling",
    5 => "Plang",
    7 => "Plong",
  }.freeze

  def self.convert(count)
    Raindrops.new(count).convert
  end

  def initialize(count)
    @count = count
  end

  def convert
    pling_sounds(count) || count.to_s
  end

  private

  attr_reader :count

  def pling_sounds(count)
    s = PLING_NOISES.map { |factor, sound|
      sound if (count % factor).zero? }.join
    s unless s.empty?
  end

end