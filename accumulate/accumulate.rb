# our own version of `map`
module Accumulate
  def accumulate
    inject([]) do |acc, item|
      acc << yield(item)
    end
  end
end

class Array
  include Accumulate
end
