class Domino
  def initialize(piece)
    @domino = piece
  end

  def can_chain?(other)
    @domino.any? { |d| other.match?(d) }
  end

  def match?(d)
    @domino.include?(d)
  end

  def left
    @domino[0]
  end

  def right
    @domino[1]
  end

  def reverse!
    @domino.reverse!
    self
  end
end

module Without
  refine Array do
    def without(el)
      drop_index = self.index(el)
      self.reject.with_index {|_,i| i == drop_index }
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
    return true if @dominoes.size == 0

    first, *rest = @dominoes.map {|x| Domino.new(x) }
    _chain(rest, [first]) ||
    _chain(rest, [first.reverse!])
  end

  private

  def connects_itself?(chain)
    chain.first.left == chain.last.right
  end

  def _chain(unused, chain)
    return true if unused.empty? && connects_itself?(chain)

    available = unused.select {|d| d.match? chain.last.right }
    available.find do |dominoe|
      # puts "new_unused: #{new_unused}"
      # puts "new_chain: #{new_chain}"
      _chain(
        unused.without(dominoe),
        chain_add_dominoe(chain, dominoe)
      )
    end
  end

  def chain_add_dominoe(chain, domino)
    domino.reverse! if chain.last.right != domino.left
    [*chain, domino]
  end
end