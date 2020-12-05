#!/bin/sh
failures=$(terraform fmt -write=false -list=true -recursive)
if [ -n $failures ]; then 
  echo "Following files need to be formatted\n" $failures; 
  terraform fmt -diff -write=false -recursive
  exit 1; 
fi
