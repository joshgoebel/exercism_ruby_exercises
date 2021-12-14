class Triangle
  def initialize(height)
    @height = height
  end

  def rows
    last_row = [1]
    (@height).times.map do |h|
      last_row=(h+1).times.map do |i|
        next 1 if i == 0 # to prevent row[-1] below

        left = last_row[i-1]
        right = last_row[i] || 0
        left + right
      end
    end
  end
end
