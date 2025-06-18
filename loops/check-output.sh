#!/bin/bash

expected_min=195000
expected_max=204999

input=40
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

if [ "$result" -ge "$expected_min" ] && [ "$result" -le "$expected_max" ]; then
  echo "Check passed"
  exit 0
else
  echo "Incorrect output: Out of range"
  echo "$result"
  exit 1
fi