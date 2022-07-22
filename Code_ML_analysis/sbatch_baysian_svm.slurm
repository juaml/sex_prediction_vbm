#!/usr/bin/bash
#
#SBATCH -J transgender

echo test

set -x

pushd $PROJ_DIR
mkdir -p $OUTPUT_DIR
mkdir -p $WORK_DIR
rm -rf $WORK_DIR/*
# compose the command
cmd="
    python \
    $CODE_DIR/train_baysian_svm.py \
     $PROJ_DIR \
     $OUTPUT_DIR \
     $1 \
     $2
   "
#      --omp-nthreads $HPC_NODE_OMP_NTHREAD \ # add as parameter?
echo $cmd
eval ${cmd}

popd

exit 0
