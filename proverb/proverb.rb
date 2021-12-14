class Proverb
  def initialize(*list, **opts)
    @list = list
    @first_cause = "#{opts[:qualifier]} #{@list.first}".strip
  end

  def to_s
    [body, footer].join
  end

  private
  def footer
     "And all for the want of a #{@first_cause}."
  end

  def body
    @list[0..-2].each.with_index.sum("") do |item, i|
      "For want of a #{item} the #{@list[i+1]} was lost.\n"
    end
  end
end
