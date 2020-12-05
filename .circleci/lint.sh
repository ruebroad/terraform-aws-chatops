#!/bin/sh
failures=$(terraform fmt -write=false -list=true -recursive)
if [ -n $failures ]; then echo -e "Following files need to be formatted\n" $failures; exit 1; fi
