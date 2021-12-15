class Atbash
  ENGLISH_ALPHABET = "abcdefghijklmnopqrstuvwxyz"
  CIPHER = ENGLISH_ALPHABET.reverse
  RECODER = ENGLISH_ALPHABET.chars.zip(CIPHER.chars).to_h
  private_constant :ENGLISH_ALPHABET, :CIPHER, :RECODER

  def self.encode(x)
    Atbash.new.encode(x)
  end

  def self.decode(x)
    Atbash.new.decode(x)
  end

  def encode(text)
    group_letters(recode(text), group_size: 5)
  end

  def decode(text)
    recode(text)
  end

  private

  # encoding and decoding are really the same process except
  # that encoding groups characters into sets of 5
  def recode(text)
    text.downcase.chars.map(&method(:encode_char)).join("")
  end

  def encode_char(c)
    return c if c.match(/\d/)

    RECODER[c]
  end

  def group_letters(text, group_size:)
    text.scan(/\w{#{group_size}}|\w+/).join(" ")
  end
end