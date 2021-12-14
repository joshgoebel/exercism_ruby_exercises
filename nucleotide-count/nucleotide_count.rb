module Nucleotide
  def self.from_dna(strand)
    DNAStrand.new(strand)
  end
end

class DNAStrand
  DNA_REGEX = /^[GTAC]*$/.freeze
  private_constant :DNA_REGEX

  def initialize(strand)
    @dna = strand
    validate!
  end

  def count(letter)
    dna.each_char.count { |x| x == letter }
    # histogram[letter]
  end

  def histogram
    initial_counts = { 'A' => 0, 'T' => 0, 'C' => 0, 'G' => 0 }
    dna.each_char.with_object(initial_counts) do |nucleotide, histogram|
      histogram[nucleotide] += 1
    end
  end

  private

  attr_reader :dna

  def validate!
    raise ArgumentError, "invalid DNA" unless @dna.match(DNA_REGEX)
  end
end