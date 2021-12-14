class Change
  class ImpossibleCombinationError < StandardError; end
  class NegativeTargetError < StandardError; end

  def self.generate(denominations, amount)
    self.new(denominations, amount).change
  end

  def initialize(denominations, amount)
    @denominations = denominations.sort.uniq
    @amount = amount
  end

  def change
    return [] if @amount.zero?
    raise Change::NegativeTargetError if @amount < 0
    raise Change::ImpossibleCombinationError if @denominations.sort.first > @amount

    # try finding a single coin first
    if single_coin = @denominations.find {|x| x == @amount }
      return [single_coin]
    end

    combo_change(@amount)
  end

  private
  # Brilliant, but possibly not the fastest
  # https://exercism.io/tracks/ruby/exercises/change/solutions/433e308178044f719fe81cd717865f9a
  def combo_change(amount)
    # we need at least 2 coins because we cover the singel coint case above
    (2..amount).each do |coin_count|
      @denominations.repeated_combination(coin_count).each do |coin_combo|
        return coin_combo if coin_combo.sum == amount
      end
    end
    raise ImpossibleCombinationError
  end
end
