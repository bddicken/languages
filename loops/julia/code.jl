function main(u)
    a = zeros(Int,10^4)
    r = rand(1:10^4)
    for i ∈ 1:10^4
        for j ∈ 1:10^5
            a[i] += j%u
        end
        a[i] += r
    end
    println(a[r])
end

isinteractive() || main(parse(Int, first(ARGS)))
