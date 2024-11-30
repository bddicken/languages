u = ARGV[0].to_i
r = 0

(1...u).each do |i|
  r &+= fibonacci(i)
end

puts r

def fibonacci(n : Int32) : Int32
  case n
    when 0 then 0
    when 1 then 1
    else fibonacci(n &- 1) &+ fibonacci(n &- 2)
  end
end