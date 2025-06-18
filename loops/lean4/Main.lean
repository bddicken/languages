import Std

def main (args : List String) : IO Unit := do
  let u := args[0]!.toNat!.pred
  let r ← IO.rand 0 10000
  let mut a := Array.mkArray 10000 0
  for i in [0:10000] do
    let mut sum := 0
    for j in [0:100000] do
      sum := sum + (j % u)
    a := a.set! i (sum + r)
  IO.println (a.get! r)
