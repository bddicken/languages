function main()
    u = parse(Int32, ARGS[1])

    a = zeros(10000, 1)
    r = rand(1:10000)
    for i = 1:10000
        for j = 1:100000
            a[i] = a[i] + j%u
        end
        a[i] = a[i] + r
    end

    println(a[r])
end

main()