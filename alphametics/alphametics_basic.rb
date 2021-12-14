class Alphametics
  ALPHA = /[A-Z]/
  class LeadingZeroError < StandardError; end

  def self.solve(str)
    self.new(str).solve
  end

  def initialize(str)
    @str = str
  end

  def solve
    parse
    # all_permuations.each do |values|
    #   return values if valid_solution?(values)
    # end
    (0..9).to_a.permutation(@letters.size).each do |values|
      if @solver.call(values)
        return @letters.zip(values).to_h
      end
    end
    {}
  end

  private

  def parse
    left, right = @str.split("==")
    @left_terms = left.split("+").map(&:strip)
    @right_term = right.strip
    @letters = @str.scan(ALPHA).unshift(@right_term[0]).uniq
    @first_letters = @str.scan(/\b[A-Z]/).uniq

    args = @letters.join(", ").downcase
    left = @left_terms.map {|x| term_to_code(x) }.join(" + ")
    right = term_to_code(@right_term)
    body = "#{left} == #{right}"
    first_not_zero = @first_letters.map {|x| "(#{x.downcase} != 0)"}.join(" && ")
    code = "Proc.new { |#{args}| #{first_not_zero} && #{body} }"
    # puts code
    @solver = eval(code)
  end

  def valid_solution?(values)
    eval_term(@right_term, values) == eval_side(@left_terms, values)
  rescue LeadingZeroError
    false
  end

  def term_to_code(term)
    term.downcase
      .reverse.each_char.with_index
      .map {|x,i| i>0 ? "#{x}*#{10**i}" : x }
      .reverse.join(" + ")
  end

  def eval_side(terms, values)
    terms
      .map { |term| eval_term(term, values) }
      .sum
  end

  def eval_term(term, values)
    raise LeadingZeroError if values[term.chr] == 0

    term.chars.map! { |c| values[c] }.join.to_i
    # term.each_char.sum("") { |c| values[c] }.to_i
    # term.gsub(/./) { |c| values[c] }.to_i
  end

  def all_permuations
    Enumerator.new do |y|
      (0..9).to_a.permutation(@letters.size).each do |set|
        values = @letters.zip(set).to_h
        y << values
      end
    end
  end

end
