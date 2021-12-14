class OcrNumbers
  OCR = {
    [" _ ",
     "| |",
     "|_|",
     "   "] => 0,
    ["   ",
     "  |",
     "  |",
     "   "] => 1,
    [" _ ",
     " _|",
     "|_ ",
     "   "] => 2,
    [" _ ",
     " _|",
     " _|",
     "   "] => 3,
    ["   ",
     "|_|",
     "  |",
     "   "] => 4,
    [" _ ",
     "|_ ",
     " _|",
     "   "] => 5,
    [" _ ",
     "|_ ",
     "|_|",
     "   "] => 6,
    [" _ ",
     "  |",
     "  |",
     "   "] => 7,
    [" _ ",
     "|_|",
     "|_|",
     "   "] => 8,
    [" _ ",
     "|_|",
     " _|",
     "   "] => 9,
  }

  def self.convert(input)
    self.new(input).convert
  end

  def initialize(str)
    @str = str
    @lines = @str.split("\n")
  end

  def convert
    validate!
    vertical_segments.map { |s|
      split_into_chars(s).map { |x|
        recognize_char(x) }.join }.join(",")
  end

  private
  def recognize_char(lines)
    num = OCR[lines] || "?"
    num.to_s
  end

  def vertical_segments
    @lines.each_slice(4).map {|p| p }
  end

  def split_into_chars(lines)
    len = lines.first.size / 3
    len.times.map do |x|
      # grab out segment right out of the middle of each of the four lines
      lines.map {|line| line.slice(x*3, 3) }
    end
  end

  def validate!
    raise ArgumentError.new("too many lines (must be multiple of 4)") unless @lines.size % 4 == 0
    raise ArgumentError.new("incorrect columns") unless @lines.all? {|x| x.size % 3 == 0 }
  end
end
