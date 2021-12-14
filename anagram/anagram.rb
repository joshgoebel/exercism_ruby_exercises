class Anagram
  def initialize(word)
    @word = word.downcase
  end

  def match(potential_anagrams)
    potential_anagrams
      .reject { |potential| same_word?(potential, word) }
      .select { |potential| anagrams?(potential, word) }
  end

  private

  attr_reader :word

  def anagrams?(word, other)
    normalize(word) == normalize(other)
  end

  def same_word?(a, b)
    a.downcase == b.downcase
  end

  def normalize(word)
    word.downcase.chars.sort.join("")
  end
end