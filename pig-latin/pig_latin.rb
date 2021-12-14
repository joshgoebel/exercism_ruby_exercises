class PigLatin
  VOWEL_SOUNDS = %w[A E I O U XR YT]
  Y_AFTER_CLUSTER = /^([^aeiouy]+)(y.*)$/
  BEGINS_CONSONANT = /^([^aeiou]?qu|[^aeiou]+)(.*)$/
  private_constant :VOWEL_SOUNDS, :Y_AFTER_CLUSTER, :BEGINS_CONSONANT

  def self.translate(phrase)
    PigLatin.new(phrase).translate
  end

  def translate
    @phrase.split(" ").map(&method(:translate_word)).join(" ")
  end

  private

  def initialize(phrase)
    @phrase = phrase
  end

  def begins_with_vowel_sound?(word)
    word = word.upcase
    VOWEL_SOUNDS.any? { |prefix| word.start_with?(prefix) }
  end

  def translate_word(word)
    if begins_with_vowel_sound?(word)
      "#{word}ay"
    elsif (match = word.match(Y_AFTER_CLUSTER))
      "#{match[2]}#{match[1]}ay"
    elsif (match = word.match(BEGINS_CONSONANT))
      "#{match[2]}#{match[1]}ay"
    else
      word
    end
  end
end