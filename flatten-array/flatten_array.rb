class FlattenArray
  def self.flatten(arr, result = [])
    arr.each do |item|
      next if item.nil?
      next flatten(item, result) if item.respond_to?(:each)

      result.push(item)
    end

    return result
  end
end
