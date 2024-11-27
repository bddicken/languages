function next(n:i32):i32 {
  if (n == 0) return 0;
  if (n == 1) return 1;
  return next(n-1) + next(n-2);
}

export function fibonacci(u:i32):i32 {
  let r = 0;
  for (let i = 1; i < u; i++) {
    r += next(i);
  }
  return r;
}
