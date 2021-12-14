module Enumerable
  # BACKPORT: from Ruby 2.7
  #
  # convert an array to a hash where the keys are the values
  # from the array and the value is the count of how many times
  # a given item was present in that array
  def tally
    group_by(&:itself).transform_values(&:count)
  end
end

class Phrase
  WORD_REGEX = /\b[\w']+\b/

  def initialize(phrase)
    @phrase = phrase
  end

  def word_count
    words.tally
  end

  private

  attr_reader :phrase

  def words
    phrase
      .downcase
      .scan(WORD_REGEX)
  end
end