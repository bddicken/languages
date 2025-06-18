expected_min=1950000
expected_max=1959999

output=$(echo "${*}" | sed 's/\x1b\[[0-9;]*m//g')

if [ "$output" -ge "$expected_min" ] && [ "$output" -le "$expected_max" ]; then
  echo "Check passed"
  exit 0
else
  echo "Incorrect output: Out of range"
  echo "$output"
  exit 1
fi