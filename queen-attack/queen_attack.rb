class Queens
  def initialize(white: nil, black: nil)
    @white = Queen.new(white) if white
    @black = Queen.new(black) if black
  end

  def attack?
    @white.can_attack?(@black)
  end
end

class Piece
  attr_reader :rank, :file
  RANKS = (0..7)
  FILES = (0..7)

  def initialize(arr)
    @file = arr[0]
    @rank = arr[1]
    validate!
  end

  def validate!
    raise ArgumentError unless RANKS.include? @rank
    raise ArgumentError unless FILES.include? @file
  end

  private
  def same_file?(other)
    file.eql?(other.file)
  end

  def same_rank?(other)
    rank.eql?(other.rank)
  end

  def same_diagonal?(other)
    (rank-other.rank).abs ==
      (file-other.file).abs
  end
end

class Queen < Piece
  def can_attack?(piece)
    same_file?(piece) or same_rank?(piece) or same_diagonal?(piece)
  end
end
