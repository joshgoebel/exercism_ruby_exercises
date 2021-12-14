MINE = "*"
EMPTY_TILE = " "

# board, composed of tiles
class Board

  def self.transform(board)
    new(board).solve
  end

  def initialize(rows)
    @rows = rows
  end

  def solve
    parse
    validate!

    inside_grid_squares.each do |(x, y), tile|
      next if mine?(tile)

      set(x, y, mine_count_at(x, y))
    end
    @rows
  end

  HORIZONTAL_BORDER = /\+\-+\+/
  VALID_TILES = /[0-9* +\-|]/
  SIDE_BORDER = /^|.*|$/

  private_constant :HORIZONTAL_BORDER, :VALID_TILES, :SIDE_BORDER

  private

  attr_reader :height, :width

  def mine?(tile)
    tile == MINE
  end

  def mine_count_at(x,y)
    tiles_surrounding(x, y)
      .count(&method(:mine?))
      .then(&method(:count_to_tile))
  end

  def count_to_tile(c)
    return EMPTY_TILE if c.zero?

    c.to_s
  end

  def inside_grid_squares
    Enumerator.new do |yielder|
      (1..width).each do |x|
        (1..height).each do |y|
          yielder << [[x,y], at(x,y)]
        end
      end
    end
  end

  def tiles_surrounding(x, y)
    Enumerator.new do |yielder|
      (-1..1).each do |x_offset|
        (-1..1).each do |y_offset|
          next if x_offset.zero? && y_offset.zero? # center

          yielder << at(x + x_offset, y + y_offset)
        end
      end
    end
  end

  def validate!
    raise ArgumentError unless @rows.all? {|x| x.length == width + 2 }
    raise ArgumentError unless
      @rows.first.match?(HORIZONTAL_BORDER) &&
      @rows.last.match?(HORIZONTAL_BORDER) &&
      middle_rows.all?(&SIDE_BORDER.method(:match?))
  end

  def middle_rows
    @rows[1..-2]
  end

  def at(x, y)
    @rows[y][x].tap do |tile|
      raise ArgumentError unless tile =~ VALID_TILES
    end
  end

  def set(x, y, tile)
    @rows[y][x] = tile
  end

  def parse
    @width = @rows.first.size - 2
    @height = @rows.size - 2
  end
end
