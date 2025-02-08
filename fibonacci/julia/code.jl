fibonacci(n) = n < 2 ? n : fibonacci(n-1) + fibonacci(n-2)

main(u) = println(sum(fibonacci, 1:u))

isinteractive() || main(parse(Int, ARGS[1]))
