class Matrix
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def rows
    data.each_line.map {|x| x.split.map(&:to_i )}
  end

  def columns
    rows.transpose
  end

end

