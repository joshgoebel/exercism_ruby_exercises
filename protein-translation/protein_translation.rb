class InvalidCodonError < StandardError
end

class Codon
  CODON_to_PROTEIN = {
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UGG" =>	"Tryptophan"
  }
  private_constant :CODON_to_PROTEIN

  STOP_CODONS = %w[UAA UAG UGA]

  def initialize(codon)
    @codon = codon
  end

  def stop?
    STOP_CODONS.include?(@codon)
  end

  def protein
    CODON_to_PROTEIN[@codon]
  end
end

class Translation
  VALID_CODONS_RE = /^([AUGC]{3})*$/
  private_constant :VALID_CODONS_RE

  def self.of_codon(codon)
    codon = Codon.new(codon)
    return "STOP" if codon.stop? # to make tests happy, bad design IMHO

    codon.protein
  end

  def self.of_rna(rna)
    rna_to_codons(rna)
      .take_while { |codon| !codon.stop? }
      .map(&:protein)
  end

  def self.rna_to_codons(rna)
    raise InvalidCodonError unless VALID_CODONS_RE.match(rna)

    rna.scan(/\w{3}/).map { |w| Codon.new(w) }
  end

end