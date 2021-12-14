class ETL
  def self.transform(old_table)
    old_table.each_with_object({}) do |(value, letters), table|
      letters.each do |letter|
        table[letter.downcase] = value
      end
    end
  end
end