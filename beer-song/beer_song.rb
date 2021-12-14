class BeerSong
  def self.recite(verse, count)
    BeerSong.new(verse, count).recite
  end

  def recite()
    @count.times.map { |i| verse(@verse - i) }.join("\n")
  end

  private

  def initialize(verse, count)
    @verse = verse
    @count = count
  end

  def verse(n)
    return no_more_verse if n.zero?

    "#{bottles(n)} of beer on the wall, #{bottles(n)} of beer.\n" +
    "Take #{one(n)} down and pass it around, #{bottles(n-1)} of beer on the wall.\n"
  end

  def no_more_verse
    "No more bottles of beer on the wall, no more bottles of beer.\n" +
    "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
  end

  def bottles(n)
    return "no more bottles" if n.zero?
    return "1 bottle" if n == 1

    "#{n} bottles"
  end

  def one(n)
    n==1 ? "it" : "one"
  end
end