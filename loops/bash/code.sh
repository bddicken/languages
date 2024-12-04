#!/bin/bash

#Gets the input number and converts it to an integer
u=$1

#Generates a random number between 0 and 9999
r=$(( RANDOM % 10000 ))

#Initializes an array with 10000 elements equal to 0
a=()
for (( i=0; i<10000; i++ )); do
  a[i]=0
done

#Perform loops
for (( i=0; i<10000; i++ )); do
  for (( j=0; j<100000; j++ )); do
    a[i]=$(( a[i] + (j % u) ))
  done
  #Adds the random number to array
  a[i]=$(( a[i] + r ))
done

#Print `a[r]`
echo "${a[r]}"
