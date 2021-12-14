class Pangram
  ENGLISH_ALPHABET = /[a-z]/
  private_constant :ENGLISH_ALPHABET

  def self.pangram?(sentence)
    sentence
      .downcase
      .scan(ENGLISH_ALPHABET)
      .uniq
      .size == 26
  end
end