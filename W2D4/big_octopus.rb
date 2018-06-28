arr = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']

def sluggish(arr)
  longest = arr.first

  (0...arr.length-1).to_a.each do |i|
    (i+1...arr.length).to_a.each do |j|
      longest = arr[j] if arr[j].length > arr[i].length
    end
  end
  longest
end

p sluggish(arr)

def quicksort(arr,&prc)
  return arr if arr.length < 2
  prc ||= Proc.new { |x,y| x.length <=> y.length}
  pivot = arr.first
  left = arr[1..-1].select{|num| prc.call(num,pivot) == -1}
  right = arr[1..-1].select{|num| prc.call(num,pivot) != -1}
  quicksort(left, &prc) + [pivot] + quicksort(right, &prc)
end

def dominant(arr)
  quicksort(arr).last
end

p dominant(arr)

def clever(arr)
  longest = ""
  arr.each do |fish|
    longest = fish if fish.length > longest.length
  end
  longest
end

p clever(arr)

tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

def slow_dance(dir,tiles_array)
  correct_leg = nil
  tiles_array.each_with_index do |direction, leg|
    correct_leg = leg if direction == dir
  end
  correct_leg
end

p slow_dance("up", tiles_array)
p slow_dance("right-down", tiles_array)

tiles_hash = {"up" => 0, "right-up"=> 1, "right"=> 2, "right-down"=> 3, "down"=> 4, "left-down"=> 5, "left"=> 6,  "left-up"=> 7}

def fast_dance(dir,tiles_hash)
tiles_hash[dir]
end

p fast_dance("up", tiles_hash)
p fast_dance("right-down", tiles_hash)
