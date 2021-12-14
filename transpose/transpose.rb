class TextGrid
  attr_reader :width, :height

  def initialize(grid:nil, width:nil, height:nil)
    if grid
      @data = grid
      parse
    else
      @width, @height = width, height
      make_empty
    end
  end

  def traverse(&blk)
    width.times.each do |x|
      height.times.each do |y|
        blk.call(x, y, fetch(x,y))
      end
    end
  end

  def transpose
    self.class.new(width: height, height: width).tap do |transposed|
      traverse do |x, y, ch|
        transposed.set(y,x, ch)
      end
    end
  end

  def to_s
    strip_zeros(@data)
  end

  def fetch(x, y)
    @lines[y][x]
  end

  def set(x, y, chr)
    @data[index_of(x,y)] = chr || "\0"
  end

  def make_empty
    @data = ([" " * width] * height).join("\n")
  end

  private

  def index_of(x, y)
    (width+1) * y + x
  end

  def strip_zeros(s)
    # remove padding from end of lines and change
    # padding at beginning of lines to spacing
    s.gsub(/\0+$/,'').gsub("\0",' ')
  end


  def parse
    @lines = @data.split("\n")
    @width = @lines.max_by(&:size).size
    @height = @lines.size
  end

end

module Transpose
  def self.transpose(input)
    return "" if input.empty?

    TextGrid.new(grid: input)
      .transpose.to_s
  end
end