module Acronym
  def self.abbreviate(s)
    s.scan(/\b\w/).join.upcase
  end
end
