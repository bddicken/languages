def fibonacci(n : Int32) : Int32
	return n if n < 2
   
	fibonacci(n &- 1) &+ fibonacci(n &- 2)
end