class ResistorColorDuo
  COLOR_to_RESISTANCE = {
    "black" => 0,
    "brown" => 1,
    "red" => 2,
    "orange" => 3,
    "yellow" => 4,
    "green" => 5,
    "blue" => 6,
    "violet" => 7,
    "grey" => 8,
    "white" => 9
  }.freeze

  def self.value(bands)
    bands.map(&COLOR_to_RESISTANCE).join.to_i
  end
end