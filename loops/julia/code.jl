let
    a = zeros(Int,10^4)
    u = parse(Int,ARGS[1])
    r = rand(1:10^4)
    @inbounds for i ∈ 1:10^4
        @inbounds for j ∈ 1:10^5
            a[i] = a[i] + j%u 
        end
        a[i] = a[i] + r
    end
    println(a[r])
end