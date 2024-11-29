# base case 1
fibonacci(::Val{0}) = 0
# base case 2
fibonacci(::Val{1}) = 1
# general case
fibonacci(::Val{n}) where n = fibonacci(Val(n-1)) + fibonacci(Val(n-2))

let
    u = parse(Int,ARGS[1])
    r = 0
    for i ∈ 1:u
        r += fibonacci(Val(i))
    end
    println(r)
end