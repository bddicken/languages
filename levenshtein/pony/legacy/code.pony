primitive Min
  fun i64(a: I64, b: I64): I64 => if a < b then a else b end

primitive Levenshtein
  fun distance(a: String box, b: String box): I64 =>
    let a_len = a.size().i64()
    let b_len = b.size().i64()
    if b_len < a_len then
      distance(b, a)
    else
      let m = a_len
      let n = b_len
      let prev = Array[I64].init(0, (m + 1).usize())
      let curr = Array[I64].init(0, (m + 1).usize())

      var i: I64 = 0
      while i <= m do
        try prev.update(i.usize(), i)? end
        i = i + 1
      end

      i = 1
      while i <= n do
        try curr.update(0, i)? end
        var j: I64 = 1
        while j <= m do
          let ac: U8 = try a((j - 1).usize())? else U8(0) end
          let bc: U8 = try b((i - 1).usize())? else U8(0) end
          let cost: I64 = if ac == bc then 0 else 1 end
          let del = try prev(j.usize())? else 0 end + 1
          let ins = try curr((j - 1).usize())? else 0 end + 1
          let sub = try prev((j - 1).usize())? else 0 end + cost
          let v = Min.i64(Min.i64(del, ins), sub)
          try curr.update(j.usize(), v)? end
          j = j + 1
        end
        // prev = curr
        var k: I64 = 0
        while k <= m do
          try prev.update(k.usize(), try curr(k.usize())? else 0 end)? end
          k = k + 1
        end
        i = i + 1
      end

      try prev(m.usize())? else 0 end
    end

actor Main
  new create(env: Env) =>
    let args = env.args
    let count = args.size()
    var min_distance: I64 = -1
    var times: I64 = 0

    var i: I64 = 1
    while i < count.i64() do
      var j: I64 = 1
      while j < count.i64() do
        if i != j then
          let s1 = try args(i.usize())? else "" end
          let s2 = try args(j.usize())? else "" end
          let d = Levenshtein.distance(s1, s2)
          if (min_distance == -1) or (d < min_distance) then
            min_distance = d
          end
          times = times + 1
        end
        j = j + 1
      end
      i = i + 1
    end

    env.out.print("times: " + times.string())
    env.out.print("min_distance: " + min_distance.string())
    env.exitcode(0)
