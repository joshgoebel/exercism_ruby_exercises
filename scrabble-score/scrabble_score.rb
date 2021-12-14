class ScrabbleWord

  TILE_to_SCORE = Hash.new(1).merge({
    # A, E, I, O, U, L, N, R, S, T  => 1
    "D" => 2, "G" => 2,
    "B" => 3, "C" => 3, "M" => 3, "P" => 3,
    "F" => 4 , "H" => 4 , "V" => 4 , "W" => 4 , "Y" => 4,
    "K" => 5,
    "J" => 8, "X" => 8,
    "Q" => 10, "Z" => 10
  })

  def self.score(word)
    new(word).score
  end

  def score
    valid_tiles.sum(&TILE_to_SCORE)
  end

  def initialize(word)
    @word = word || ''
  end

  private

  def valid_tiles
    @word.upcase.scan(/[A-Z]/)
  end

end
Scrabble = ScrabbleWord
