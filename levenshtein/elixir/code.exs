defmodule Levenshtein do
  @moduledoc """
  Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
  Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
  Time Complexity: O(m*n) where m and n are the lengths of the input strings
  """

  @doc """
  Calculates the Levenshtein distance between two strings
  """
  def distance(s1, s2) when is_binary(s1) and is_binary(s2) do
    # Early termination checks
    cond do
      s1 == s2 -> 0
      byte_size(s1) == 0 -> byte_size(s2)
      byte_size(s2) == 0 -> byte_size(s1)
      true ->
        # Make s1 the shorter string for space optimization
        {s1, s2} = if byte_size(s1) > byte_size(s2), do: {s2, s1}, else: {s1, s2}
        compute_distance(s1, s2)
    end
  end

  defp compute_distance(s1, s2) do
    # Convert strings to charlists for faster access
    s1_chars = String.to_charlist(s1)
    s2_chars = String.to_charlist(s2)
    m = length(s1_chars)
    n = length(s2_chars)

    # Initialize first row
    prev_row = Enum.to_list(0..m)

    # Main computation loop
    Enum.reduce(1..n, prev_row, fn j, prev_row ->
      # Create new row starting with the current index
      curr_row = [j | compute_row(s1_chars, s2_chars, prev_row, j, m)]
      curr_row
    end)
    |> List.last()
  end

  defp compute_row(s1_chars, s2_chars, prev_row, j, m) do
    Enum.reduce(1..m, {[0], prev_row}, fn i, {curr_row, prev_row} ->
      cost = if Enum.at(s1_chars, i-1) == Enum.at(s2_chars, j-1), do: 0, else: 1
      
      value = min(
        Enum.at(prev_row, i) + 1,          # deletion
        List.first(curr_row) + 1,          # insertion
        Enum.at(prev_row, i-1) + cost      # substitution
      )
      
      {[value | curr_row], prev_row}
    end)
    |> elem(0)
    |> Enum.reverse()
  end

  defp min(a, b, c), do: Enum.min([a, b, c])
end

# Main program
case System.argv() do
  [] ->
    IO.puts("Please provide at least two strings as arguments.")
    System.halt(1)

  args ->
    # Generate all pairs of indices
    pairs = for i <- 0..(length(args)-1),
                j <- 0..(length(args)-1),
                i != j,
                do: {i, j}

    # Calculate distances for all pairs
    distances = Enum.map(pairs, fn {i, j} ->
      Levenshtein.distance(Enum.at(args, i), Enum.at(args, j))
    end)

    min_distance = if Enum.empty?(distances), do: -1, else: Enum.min(distances)
    
    IO.puts("times: #{length(pairs)}")
    IO.puts("min_distance: #{min_distance}")
end
