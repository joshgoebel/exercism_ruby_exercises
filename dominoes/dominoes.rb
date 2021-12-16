class Domino
  attr_reader :digits

  def initialize(piece)
    @digits = piece
  end

  def can_chain?(other)
    digits.any? { |d| other.matches?(d) }
  end

  def matches?(d)
    digits.include?(d)
  end

  def left
    digits.first
  end

  def right
    digits.last
  end

  def reverse
    Domino.new(digits.reverse)
  end
end

module Without
  refine Array do
    def without(el)
      drop_index = index(el)
      reject.with_index { |_,i| i == drop_index }
    end
  end
end

class Dominoes
  using Without
  def self.chain?(dominoes)
    Dominoes.new(dominoes).chain?
  end

  def initialize(dominoes)
    @dominoes = dominoes
  end

  def chain?
    @i = 0
    return true if @dominoes.size.zero?

    first, *rest = @dominoes.map { |x| Domino.new(x) }
    r = _chain(rest, [first]) || _chain(rest, [first.reverse])
    puts("iterations: #{@i}")
    r
  end

  private

  def connects_itself?(chain)
    chain.first.left == chain.last.right
  end

  def _chain(unused, chain)
    @i += 1
    return true if unused.empty? && connects_itself?(chain)

    unused
      .select { |dominoe| dominoe.matches? chain.last.right }
      .find do |dominoe|
        _chain(
          unused.without(dominoe),
          chain_add_dominoe(chain, dominoe)
        )
      end
  end

  def chain_add_dominoe(chain, domino)
    if chain.last.right != domino.left
      [*chain, domino.reverse]
    else
      [*chain, domino]
    end
  end
end
