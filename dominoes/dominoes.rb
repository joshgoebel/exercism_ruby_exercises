class Dominoes
  def self.chain?(dominoes)
    Dominoes.new(dominoes).chain?
  end
  def initialize(pieces)
    @pieces = pieces
  end

  def chain?
    return true if @pieces.size == 0

    first, *rest = @pieces
    # pieces = @pieces[1..-1]
    _chain(rest, [first]) ||
    _chain(rest, [first.reverse])
  end

  private

  def connects_itself?(chain)
    chain.first[0] == chain.last[1]
  end

  def _chain(unused, chain)
    return true if unused.empty? && connects_itself?(chain)

    available = unused.select {|d| d.include? chain.last[1] }
    available.find do |d|
      drop_index = unused.index(d)
      new_unused = unused.reject.with_index {|d,i| i == drop_index }
      new_chain = add_chain(chain, d)
      # puts "new_unused: #{new_unused}"
      # puts "new_chain: #{new_chain}"
      _chain(new_unused, new_chain)
    end
  end

  def add_chain(chain, domino)
    if chain.last[1] == domino[0]
      [*chain, domino]
    else
      [*chain, domino.reverse]
    end
  end
end