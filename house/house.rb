class House
  def self.recite
    self.new.recite
  end
  def self.verse(x)
    self.new.verse(x)
  end

  # This is the cat
  # that killed the rat
  # that ate the malt
  # that lay in the house that Jack built.
  NOUNS_and_VERBS = [
    ["malt", "lay in"],
    ["rat", "ate"],
    ["cat", "killed"],
    ["dog", "worried"],
    ["cow with the crumpled horn", "tossed"],
    ["maiden all forlorn", "milked"],
    ["man all tattered and torn", "kissed"],
    ["priest all shaven and shorn", "married"],
    ["rooster that crowed in the morn", "woke"],
    ["farmer sowing his corn", "kept"],
    ["horse and the hound and the horn", "belonged to"]
  ]
  # one extra verse of "This is the house that Jack built."
  NUMBER_OF_VERSES = NOUNS_and_VERBS.size + 1

  def recite
    NUMBER_OF_VERSES
      .times
      .map(&method(:verse))
      .join("\n")
  end

  def verse(number)
    format("This is %s the house that Jack built.\n",
      nouns_and_verbs(number)
        .sum("") { |noun, verb| "#{article(noun)}\nthat #{verb} " }
        ).squeeze(" ")
  end

  private

  # if someone provided a non standard article this is where
  # I might try to deal with it, but I'm not even sure such
  # a noun would fit the "pattern" of the song
  def article(noun)
    "the #{noun}"
  end

  def nouns_and_verbs(n)
    NOUNS_and_VERBS.take(n).reverse
  end

end
