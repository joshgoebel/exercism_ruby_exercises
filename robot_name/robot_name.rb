class Robot
  @@names = {}

  MAX_NAMES_COUNT = 26 * 26 * 1000
  ALPHABET = ('A'..'Z').to_a.freeze
  DIGITS = ('0'..'9').to_a.freeze

  def self.forget
    @@names = {}
  end

  attr_reader :name

  def initialize
    @name = create_uniq_name
  end

  def reset
    @name = create_uniq_name
  end

private

  def create_uniq_name
    while loop do
      creating_name = create_random_name
      break unless uniq?(creating_name)
    end

    @@names.merge!(creating_name => true)
    creating_name
  end

  def uniq?(creating_name)
    @@names.key?(creating_name)
  end

  def create_random_name
    "#{random_letter}#{random_letter}#{random_number}#{random_number}#{random_number}"
  end

  def random_letter
    ALPHABET.sample
  end

  def random_number
    DIGITS.sample
  end
end
