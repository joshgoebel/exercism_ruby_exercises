class RotationalCipher
  ROT_TABLE = ("a".."z").to_a + ("A".."Z").to_a

  def self.rotate(s, rot)
    return s if rot==0

    s.each_char.sum("") do |x|
      i = ROT_TABLE.index(x)
      next x if i.nil? # non-A-Z

      ROT_TABLE[
        # rotation cipher
        ((i+rot) % 26) \
        + (i>=26 ? 26 : 0)
        # shift uppercase back into uppercase end of ROT table
      ]
    end
  end

end
