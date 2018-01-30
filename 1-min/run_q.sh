#!/bin/bash

OK="(\033[0;32m   OK   \033[0m)"
FAILED="(\033[0;31m FAILED \033[0m)"

steps=( $(ls -1v *inp | sed 's/.inp//') )

for step in ${steps[@]}
do
  echo "Running step ${step}"
  mpirun Qdyn6p ${step}.inp > ${step}.log

  if [[ $(grep "terminated normally" ${step}.log) ]]; then 
    echo "OK"
  else
    echo "---  FAILED  ---"
    echo "See ${step}.log for details."
    break
  fi
done
