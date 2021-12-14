class Complement
  DNA_TO_RNA = {
    "G" => "C",
    "C" => "G",
    "T" => "A",
    "A" => "U",
  }

  def self.of_dna(s)
    s.each_char.map { |c| DNA_TO_RNA[c] }.join
  end
end
