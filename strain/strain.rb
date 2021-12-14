module KeepDiscard
  def keep
    each_with_object([]) do |n, acc|
      acc << n if yield(n)
    end
  end

  def discard
    # to discard is to keep those that do NOT match
    keep { |x| !yield(x) }
  end
end

class Array
  include KeepDiscard
end
