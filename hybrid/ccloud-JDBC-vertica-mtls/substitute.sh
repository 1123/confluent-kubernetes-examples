#!/bin/bash

for file in *.template; do
  replaced=$(echo $file | sed 's/.template//')
  cat $file | envsubst > $replaced
done

