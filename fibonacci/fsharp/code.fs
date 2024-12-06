[<EntryPoint>]
let main argv =
    let rec fibonacci n =
        if n < 2 then n
        else fibonacci (n - 1) + fibonacci (n - 2)

    let u = int argv[0]
    let mutable r = 0
    for i in 1..u-1 do
        r <- r + fibonacci i
    
    printfn $"{r}"
    0
