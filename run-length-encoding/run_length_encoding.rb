class RunLengthEncoding
  LETTER_RUN_RE = /([\w ])\1+/
  RLE_CHUNK_RE = /(\d+)([\w ])/
  private_constant :LETTER_RUN_RE, :RLE_CHUNK_RE

  def self.encode(data)
    encode_seq = proc { |m| "#{m.length}#{m[0]}" }

    data.gsub(LETTER_RUN_RE, &encode_seq)
  end

  def self.decode(data)
    decode_chunk = lambda { |m| $2 * $1.to_i }

    data.gsub(RLE_CHUNK_RE, &decode_chunk)
  end
end