class TwelveDays
  DAYS = 1..12
  GIFTS = [
    'a Partridge in a Pear Tree',
    'two Turtle Doves',
    'three French Hens',
    'four Calling Birds',
    'five Gold Rings',
    'six Geese-a-Laying',
    'seven Swans-a-Swimming',
    'eight Maids-a-Milking',
    'nine Ladies Dancing',
    'ten Lords-a-Leaping',
    'eleven Pipers Piping',
    'twelve Drummers Drumming'
  ]
  # ORDINALS = {
  #   1 => 'first', 2 => 'second', 3 => 'third',
  #   4 => 'fourth', 5 => 'fifth', 6 => 'sixth',
  #   7 => 'seventh', 8 => 'eighth', 9 => 'ninth',
  #   10 => 'tenth', 11 => 'eleventh', 12 => 'twelfth'
  # }
  ORDINALS = DAYS.zip([
    "first", "second", "third", "fourth", "fifth", "sixth",
    "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth"
  ]).to_h

  def self.song
    self.new.song
  end

  def song
    DAYS
      .map(&method(:verse))
      .join("\n")
  end

  private

  def verse(number)
    "On the #{nth(number)} day of Christmas " \
    "my true love gave to me: #{to_series(gifts(number))}.\n"
  end

  def gifts(count)
    GIFTS.take(count).reverse
  end

  def nth(number)
    ORDINALS[number]
  end

  def to_series(items)
    *list, last_item = items
    return last_item if items.one?

    [*list, "and #{last_item}"].join(", ")
  end

end
