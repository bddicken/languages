import Std

partial def fibonacci (n : UInt32): UInt32 :=
  match n with
  | 0 => 0
  | 1 => 1
  | _ => fibonacci (n-2) + fibonacci (n-1)

def main (args : List String) : IO Unit := do
  let u : Nat := args[0]!.toNat!
  let mut r : UInt32 := 0
  for i in [1:u] do
    r := r + fibonacci i.toUInt32
  IO.println r
