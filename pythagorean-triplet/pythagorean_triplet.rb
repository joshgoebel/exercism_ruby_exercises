class Triplet
  attr_reader :sides

  def initialize(*sides)
    @sides = sides
  end

  def sum
    sides.sum
  end

  def product
    sides.inject(:*)
  end

  def pythagorean?
    a, b, c = @sides.sort
    a**2 + b**2 == c**2
  end

  def self.where(max_factor:, min_factor: 1, sum: nil)
    factors = (min_factor..max_factor)
    TripletFinder.new(factors, sum: sum).triplets
  end
end

class TripletFinder
  def initialize(range, sum:)
    @range = range
    @sum = sum
  end

  def triplets
    valid_combos.map { |sides| Triplet.new(*sides) }
      # .select(&:pythagorean?)
  end

  private

  attr_reader :sum

  def factor_pairs(number)
    (1..Math.sqrt(number))
      .map { |divisor| [divisor, number / divisor] if number.modulo(divisor).zero? }
      .compact
  end

  # https://en.wikipedia.org/wiki/Formulas_for_generating_Pythagorean_threesomes
  def dicksons_method(seed)
    factor_pairs(seed**2 / 2).map do |a, b|
      [seed + a, seed + b, seed + a + b]
    end
  end

  def dicksons_seeds
    start = @range.first/2
    start += 1 if start.odd?

    (start...@range.last)
      .step(2)
  end

  def valid_combos
    Enumerator.new do |y|
      dicksons_seeds.each do |seed|
        dicksons_method(seed).each do |threesome|
          next unless bounded?(threesome) && sum_matches?(threesome)

          # puts "seed: #{seed}: #{threesome.inspect}"
          y << threesome
        end
        # puts
      end
    end
  end

  def bounded?(items)
    items.all? { |value| @range.cover?(value) }
  end

  def sum_matches?(set)
    return true if sum.nil?

    sum == set.sum
  end

  def all_combos_slow
    @range.to_a.combination(3)
  end

  def all_combos_other
    Enumerator.new do |y|
      (2..@range.last).each do |m|
        (1...m).each do |n|
          a = m * m - n * n
          b = 2 * m * n
          c = m * m + n * n
          triplet = [a, b, c]

          next if triplet.max > @range.last
          next if triplet.min < @range.first

          y << [triplet, 1]

          # multiples of some combos
          (2..).each do |multiplier|
            break if c*multiplier > @range.last
            y << [triplet.map {|x| x*multiplier }, multiplier]
          end

        end
      end
    end
  end
end