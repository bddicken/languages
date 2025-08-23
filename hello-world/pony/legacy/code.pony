actor Main
  new create(env: Env) =>
    env.out.print("Hello, World!")
    env.exitcode(0)
