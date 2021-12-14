# Say.new(number).in_english
class SpeakNumber

  class OutOfBoundsError < ArgumentError; end
  BOUNDS = 0...1e12
  private_constant :BOUNDS

  LARGE_NUMBER_LABELS = [
    "billion",
    "million",
    "thousand",
    ""
  ].freeze
  private_constant :LARGE_NUMBER_LABELS

  DIGIT_to_WORD = {
    0 => "zero",
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten"
  }.freeze
  private_constant :DIGIT_to_WORD

  TEENS_to_WORD = {
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen"
    # 16-19 handled programatically
  }.freeze
  private_constant :TEENS_to_WORD

  TENS_to_WORD = {
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety"
  }.freeze
  private_constant :TENS_to_WORD

  def initialize(number)
    @number = number
  end

  def in_english
    raise OutOfBoundsError unless BOUNDS.cover?(number)

    DIGIT_to_WORD[number] ||
      segments
        .map(&method(:segment_to_words))
        .then(&method(:add_labels)) # millions, thousands, etc
        .join(" ")
        .rstrip
  end

  private

  attr_reader :number

  def add_labels(segments)
    segments
      .then(&method(:left_pad_segments!))
      .zip(LARGE_NUMBER_LABELS)
      .reject { |words, _| words.empty? }
      .map { |words, label| "#{words} #{label}" }
  end

  def segments
    number.to_s.then do |num|
      num.prepend(" ") until (num.size % 3).zero?
      num.scan(/.../)
    end
  end

  def left_pad_segments!(segments)
    segments.tap do |it|
      it.prepend("") until it.size == LARGE_NUMBER_LABELS.size
    end
  end

  def segment_to_words(segment)
    [
      hundreds(segment[0].to_i),
      tens(segment[1..-1].to_i)
    ].join(" ").strip
  end

  def hundreds(digit)
    return if digit.zero?

    DIGIT_to_WORD[digit] + " hundred"
  end

  def tens(digits)
    return ones_or_teens(digits) if digits < 20

    tens = digits / 10 * 10 # isolate second digit
    [TENS_to_WORD[tens], ones_or_teens(digits % 10)].compact.join("-")
  end

  def ones_or_teens(digits)
    return if digits.zero?

    DIGIT_to_WORD[digits] ||
      TEENS_to_WORD[digits] ||
      DIGIT_to_WORD[digits % 10] + "teen"
  end
end
Say = SpeakNumber
