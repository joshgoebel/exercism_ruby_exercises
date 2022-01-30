class Domino
  attr_reader :ends

  def initialize(ends)
    raise ArgumentError unless ends.size == 2
    @ends = ends
  end

  def can_chain?(other)
    ends.any? { |pips| other.matches?(pips) }
  end

  def matches?(pips)
    ends.include?(pips)
  end

  def left
    ends.first
  end

  def right
    ends.last
  end

  def reverse
    Domino.new(ends.reverse)
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

  def chain?
    @i = 0
    return true if @raw_dominoes.size.zero?

    @dominoes = @raw_dominoes.map { |x| Domino.new(x) }
    first, *rest = @dominoes
    _chain(rest, [first]).tap do
      puts("iterations: #{@i}")
    end
  end

  private

  def initialize(raw_dominoes)
    @raw_dominoes = raw_dominoes
  end

  def both_ends_chain_connect?(chain)
    chain.first.left == chain.last.right
  end

  def count
    @dominoes.size
  end

  def _chain(unused, chain)
    @i += 1
    return true if unused.empty? && both_ends_chain_connect?(chain)

    unused
      .select { |domino| domino.matches? chain.last.right }
      .find do |domino|
        _chain(
          unused.without(domino),
          chain_add_domino(chain, domino)
        )
      end
  end

  def chain_add_domino(chain, domino)
    if chain.last.right != domino.left
      [*chain, domino.reverse]
    else
      [*chain, domino]
    end
  end
end
