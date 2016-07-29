#!/bin/sh
MAX=2
for ((  I = -$MAX ;  I <= $MAX;  I++  ))
  do
  for ((  J = -$MAX ;  J <= $MAX;  J++  ))
    do
    for ((  K = -$MAX ;  K < $MAX;  K++  ))
      do
      for ((  L = -$MAX ;  L < $MAX;  L++  ))
	do
	echo "$I $J $K $L"
	echo "$I $J $K $L\0" | tr " " "\n" |./prac01
      done
    done
  done
done
