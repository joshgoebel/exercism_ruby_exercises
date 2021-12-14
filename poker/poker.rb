class Poker
  def initialize(hands)
    @hands = hands.map { |x| Hand.new(x) }
  end

  def best_hand
    best = @hands.max_by(&:score)
    # possible we do not have a single best handle, but multiple
    @hands.select {|x| x.score == best.score }.map(&:to_a)
  end

  def debug
    puts
    @hands.each do |hand|
      puts "#{hand.to_a.inspect} #{hand.score}"
    end
  end
end

class Hand
  def initialize(cards)
    @data = cards
    @cards = cards.map { |x| Card.new(x) }
  end

  def score
    score = 0.0

    score += high_card << 36 if straight_flush?
    score += x_of_kind(4).first.value << 32 if four_of_kind?
    score += score_full_house << 24 if full_house?
    score += high_card << 20 if flush?
    score += high_card << 16 if straight?
    score += x_of_kind(3).first.value << 12 if three_of_kind?
    score += x_of_kind(2).first.value << 4 if pair?
    score += score_two_pair if two_pair?
    score += score_individual_cards
    score
  end

  def to_a
    @data
  end

  private

  def to_score(*arr)
    arr.reverse.each_with_index.sum { |v, i| v << i * 4 }
  end

  def score_two_pair
    pairs = x_of_kind(2).map(&:value).uniq.sort
    low, high = pairs
    kicker = @cards.find { |x| !pairs.include?(x.value) }.value
    to_score(high, low, kicker)
  end

  def score_full_house
    triplet = x_of_kind(3).first.value
    pair = x_of_kind(2).first.value
    to_score(triplet, pair)
  end

  def score_individual_cards
    # shift cards into a 20 bit number with high cards having, more significant bits
    sum = to_score(*@cards.map(&:value).sort.reverse)
    # then divide by 2**16 to get us back in the original 1-14 value range
    sum.to_f / 2**16
  end

  def high_card
    return straight_high_card if straight?

    @cards.map(&:value).max
  end

  def straight_high_card
    ace_low_straight? ? 5 : @cards.map(&:value).max
  end

  def x_of_kind(x)
    @cards.select { |card| @cards.count { |c| card.value == c.value } == x }
  end

  def ace_low_straight?
    faces = @cards.sort_by(&:value).map(&:number)
    faces == %w[2 3 4 5 A]
  end

  def straight?
    return true if ace_low_straight?

    values = @cards.map(&:value).sort
    (values.min..values.max).to_a == values
  end

  def full_house?
    three_of_kind? && pair?
  end

  def straight_flush?
    straight? && flush?
  end

  def three_of_kind?
    x_of_kind(3).any?
  end

  def four_of_kind?
    x_of_kind(4).any?
  end

  def flush?
    @cards.map(&:suite).uniq.size == 1
  end

  def two_pair?
    x_of_kind(2).size == 4
  end

  def pair?
    x_of_kind(2).size == 2
  end

end

class Card
  HIGH_CARDS = {
    "A" => 14,
    "K" => 13,
    "Q" => 12,
    "J" => 11
  }
  attr_reader :number, :suite
  def initialize(card)
    @card = card
    @card.match /(\d+|[JQKA])([HDSC])/
    raise "invalid card" unless $0

    @number, @suite = $1, $2
  end

  def value
    HIGH_CARDS[number] || number.to_i
  end
end