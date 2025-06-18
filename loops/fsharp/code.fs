open System

[<EntryPoint>]
let main argv =
    let u = int argv[0]
    let r = Random.Shared.Next 10_000
    let a = Array.zeroCreate 10_000

    // Ranges are inclusive in F#
    for i in 0..9999 do
        for j in 0..99_999 do
            a[i] <- a[i] + (j % u)
        a[i] <- a[i] + r

    printfn $"{a[r]}"
    0
