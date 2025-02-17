#!/bin/bash

input=""
expected_result="hello, world!"
echo_input=false

while getopts "i" opt; do
  case $opt in
    i) echo_input=true ;;
    *) ;;
  esac
done

if [ "$echo_input" = true ]; then
  echo "$input"
  exit 0
fi

result=$(echo "${*}" | sed 's/\x1b\[[0-9;]*m//g' | awk '{$1=$1};1' | tr '[:upper:]' '[:lower:]')

if [ "${result}" == "${expected_result}" ]; then
  echo "Check passed"
  exit 0
else
  echo "Incorrect result:"
  echo "${result}"
  exit 1
fi