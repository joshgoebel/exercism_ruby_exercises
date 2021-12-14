class Brackets
  BRACKETS=/[{}()\[\]]/
  PAIRED={
    "(" => ")",
    "{" => "}",
    "[" => "]"
  }.freeze

  def self.paired?(s)
    brackets = s.scan(BRACKETS)
    return false if brackets.length.odd?
    stack = []

    brackets.each do |b|
      # opening bracket
      if PAIRED[b]
        stack.push b
        next
      end
      # closing bracket
      return false unless b == PAIRED[stack.pop]
    end
    stack.empty?
  end
end
