defmodule Bench do
  def run do
    cli_num = System.argv() |> Enum.at(0) |> String.to_integer()
    fib_res = sum_fibs(cli_num)
    IO.puts(fib_res)
  end

  defp sum_fibs(i \\ 0, max, total \\ 0)
  defp sum_fibs(i, max, total) when i == max, do: total
  defp sum_fibs(i, max, total), do: sum_fibs(i + 1, max, total + fib(i))

  defp fib(n, current \\ 0, next \\ 1)
  defp fib(n, current, _next) when n == 0, do: current
  defp fib(n, current, next), do: fib(n - 1, next, current + next)
end

Bench.run()
