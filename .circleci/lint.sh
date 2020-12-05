#!/bin/sh

lint_failed="no"
for file in $(find . -name "*tf")
do
    lines=$(terraform fmt -write=false -list=true ${file} | wc -l | sed 's/[^0-9]//g')
    if [ ${lines} != "0" ]
    then
    echo "Please run terraform fmt ${file}"
    lint_failed="yes"
    fi
done
if [ ${lint_failed} != "no" ]; then exit 1; fi