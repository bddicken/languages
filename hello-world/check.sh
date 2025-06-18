expected_output="hello, world!"

trimmed_output=$(echo "${*}" | sed 's/\x1b\[[0-9;]*m//g' | awk '{$1=$1};1' | tr '[:upper:]' '[:lower:]')

if [ "${trimmed_output}" == "${expected_output}" ]; then
  echo "Check passed"
  exit 0
else
  echo "Incorrect output:"
  echo "${trimmed_output}"
  exit 1
fi