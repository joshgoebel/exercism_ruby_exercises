class Acronym
  def self.abbreviate(phrase)
    phrase.keep_if(part_of_acronym)
  end

  def self.part_of_acronym
    -> (char, last_char) { self.acronymable?(char, last_char) }
  end

  def self.acronymable?(last_char, char)
    !last_char || (last_char.match(/\W/) && char.match(/\w/))
  end
end

class String
  def keep_if(checker, accum=Accumulator.new(self))
    char = accum.remainder.chr
    return accum.string if char==""

    remainder = accum.remainder[1..-1]
    string = accum.string
    if checker.call(accum.last_char, char)
      string += char.upcase
    end
    keep_if(checker, Accumulator.new(remainder, string, char))
  end
end

class Accumulator
   attr_reader :string, :last_char, :remainder
  def initialize(remainder, string="", last_char=nil)
    @last_char = last_char
    @remainder = remainder
    @string = string
  end
end
