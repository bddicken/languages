defmodule Bench do
  def run do
    # Get an input number from the command line
    input = System.argv() |> Enum.at(0) |> String.to_integer()

    # Get a random number 0 <= r < 10k
    random_num = :rand.uniform(10_000)

    result = outer_loop(random_num, input)

    # Print a single element of the array
    IO.puts(Enum.at(result, 10_000 - random_num))
  end

  # 100k simple sum iterations, per outer loop iteration
  def inner(acc \\ 0, i \\ 1, input)
  def inner(acc, i, _input) when i == 100_000, do: acc
  def inner(acc, i, input), do: inner(rem(i, input) + acc, i + 1, input)

  # 10k outer loop iterations
  # Add a random value to each element in array
  def outer_loop(acc \\ [], j \\ 0, rand, input)
  def outer_loop(acc, j, _rand, _input) when j == 10_000, do: acc

  def outer_loop(acc, j, rand, input) do
    outer_loop([rand + inner(input) | acc], j + 1, rand, input)
  end
end

Bench.run()
