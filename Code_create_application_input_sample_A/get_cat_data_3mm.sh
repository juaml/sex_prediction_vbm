#!/bin/bash

if [ -n "$1" ]; then
  echo "using files listed in: $1"
else
  echo "file not supplied."
  exit 1
fi


while IFS= read -r infile
do
  #outfile=$( echo $infile | sed 's/cat_12.5/transgender_replication\/data/')
  outfile=$( echo $infile | sed 's/cat_12.5/cat_12.5_3mm_resolution\/data/')
  echo $outfile
  d=`dirname $outfile`
  mkdir -p $d
  if [ ! -f $outfile ]; then
    /bin/fsl5.0-flirt -in $infile -out $outfile -ref $infile -applyisoxfm 3.0
    echo "file created: $outfile"
  else
    echo "file exists: $outfile"
  fi
done < "$1"

