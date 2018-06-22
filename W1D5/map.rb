class Map
  attr_accessor :map_array

  def initialize
    @map_array = []
  end

  def set(key, value)

    id = map_array.index { |pair| pair[0] == key }
    if id
      map_array[id][1] = value
    else
      map_array << [key, value]
    end

    value
  end

  def get(key)
    map_array.each_with_index do |pair, id|
      pair[1] if pair[0] == key
    end
  end

  def delete(key)
    map_array.reject! { |pair| pair[0] == key }
    get(key)
  end

  def show
    map_array
  end
end

# Test
arr = Map.new
p arr.set("a", 3)
p arr.map_array
p arr.set("a",4)
p arr.get("a")
p arr.map_array
