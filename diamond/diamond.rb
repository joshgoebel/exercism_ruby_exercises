class Diamond
  def self.make_diamond(letter)
    new(letter).make
  end

  def initialize(letter)
    @letter = letter
  end

  def make
    mirror(top_half)
  end

  private

  def top_half
    letters.each_with_index.map do |letter, offset|
      new_empty_row.tap do |row|
        left, right = center - offset, center + offset
        row[left] = letter
        row[right] = letter
      end
    end
  end

  def mirror(grid)
    (grid + grid.reverse[1..]).join
  end

  def new_empty_row
    ((" " * width) + "\n").dup
  end

  def center
    width/2
  end

  def width
    @width ||= letters.to_a.size * 2 - 1
  end

  def letters
    "A"..@letter
  end
end
