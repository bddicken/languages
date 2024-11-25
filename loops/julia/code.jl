let
    a = zeros(Int,10^4)
    u = parse(Int,ARGS[1])
    r = only(rand(1:10^4,1))
    @inbounds for i ∈ 1:10^4
        @inbounds for j ∈ 1:10^5
            a[i] = a[i] + u
        end
        a[i] = a[i] + r
    end
    println(a[r])
end