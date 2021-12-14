require 'benchmark'

class Hamming
  def self.compute(strand1, strand2)
    # raise ArgumentError if strand1.length != strand2.length

    strand1.chars.zip(strand2.chars).count { |char1, char2| char1 != char2 }
  end
end

class Hamming2
  def self.compute(strand1, strand2)
    # raise ArgumentError if strand1.length != strand2.length

    (0...strand1.length).count { |i| strand1[i] != strand2[i] }
  end
end

class Hamming3
  def self.compute(strand1, strand2)
    # raise ArgumentError if strand1.length != strand2.length

    strand1.each_char.with_index.count {|letter, index| letter != strand2[index] }
  end
end

class Hamming
  def self.compute_chars(strand1, strand2)
    # raise ArgumentError if strand1.length != strand2.length

    strand1.chars.each_with_index.count {|letter, index| letter != strand2[index] }
  end

  def self.sellen(strand_a, strand_b)
    raise ArgumentError if strand_a.length != strand_b.length

    strand_a.length - strand_a
                        .each_char
                        .zip(strand_b.each_char)
                        .select { |a, b| a == b }
                        .length
  end
  def self.count(strand_a, strand_b)
    raise ArgumentError if strand_a.length != strand_b.length

    strand_a.length - strand_a
                        .each_char
                        .zip(strand_b.each_char)
                        .count { |a, b| a != b }
  end
end



size = 50000
n = 50

size, n = n, size

letters = "ABCD"
long = (1...size).map {|x| letters[rand(4)]}.join
long2 = (1...size).map {|x| letters[rand(4)]}.join

Benchmark.bm do |x|
  # x.report("zip") { n.times { Hamming.compute(long, long2) } }
  # x.report("index") { n.times { Hamming2.compute(long, long2) } }
  # x.report("each_char_with_index") { n.times { Hamming3.compute(long, long2) } }
  # x.report("chars_with_index") { n.times { Hamming.compute_chars(long, long2) } }
  x.report("select/length") { n.times { Hamming.sellen(long, long2) } }
  x.report("count") { n.times { Hamming.count(long, long2) } }
end


# module Hamming
#   def self.compute(strand1, strand2)
#     raise ArgumentError.new("strands different lengths") unless strand1.length == strand2.length

#     # compute_cute(strand1,strand2)
#     compute_performant(strand1,strand2)
#   end

#   def self.compute_cute(strand1, strand2)
#     [strand1.chars, strand2.chars].inject(:zip)
#       .count{ |n1,n2| n1 != n2 }
#   end

#   def self.compute_performant(strand1, strand2)
#     strand1.each_char.with_index
#       .count{|nucleotide, i| nucleotide != strand2[i] }
#   end

# end
