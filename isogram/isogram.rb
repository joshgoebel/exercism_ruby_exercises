module Isogram
  def self.isogram?(input)
    input = input.downcase.sub(/\W/,"")
    input.chars.uniq == input.chars
  end
end
