#!/bin/bash

input=37
expected_result="24157817"
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

result=$(echo "$1" | sed 's/\x1b\[[0-9;]*m//g' | awk -F ',' '{print $6}')

if [ "${result}" == "${expected_result}" ]; then
  echo "Check passed"
  exit 0
else
  echo "Incorrect result:"
  echo "${result}"
  exit 1
fi