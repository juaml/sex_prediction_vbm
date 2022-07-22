#!/bin/sh
export account="jinm72"
export partition="dc-cpu-bigmem" # partition may be left empty

eval "$(conda shell.bash hook)"

conda activate transgender
if [ $? -ne 0 ]; then
    echo "Error activating the environment"
    exit -1
fi

# directories
export PROJ_DIR=/p/project/cinm-7/hamdan1/transgender
export CODE_DIR="$PROJ_DIR/code"
export SCRATCH_DIR=/p/scratch/cinm-7/hamdan1/transgender
export CACHE_DIR=$SCRATCH_DIR/cache
export DATA_DIR="$PROJ_DIR/data"
#export subject=sub-1000201 #how to submit all subjects, parallize over trees?

### OPTIONAL PARAMETERS
export STUDY_NAME=transgender
# derivatives directory: change if you are using multiple settings
export OUTPUT_DIR=$PROJ_DIR/derivatives
export WORK_DIR="$SCRATCH_DIR/work"


# HPC
export HPC_NODE_TIME="24:00:00"
export HPC_NODE_CPU_MEM="4G"
export HPC_NODE_NCPU=128
export SLURM_JOB_NUMNODES=1

# sbatch submission file
export SBATCH_FILE="sbatch_baysian_svm.slurm" # expected to be inside CODE_DIR

#####################################################
# change below only if you know what you are doing! #
# e.g. if singularity setup changes                 #       
# check details of your HPC system before changing  #
#####################################################

if [ "$#" -ge 4 ]; then
    export postfix=$4
    export WORK_DIR="${WORK_DIR}_${postfix}"
    export OUTPUT_DIR="${OUTPUT_DIR}_${postfix}"
fi

mkdir -p ${WORK_DIR}

# sanity checks
if [ -z "$account" ]; then
	printf "Error: please set account. Can not continue.\n"
	exit 1
fi


if [ ! -e "${CODE_DIR}/${SBATCH_FILE}" ]; then
   printf "Error: SBATCH_FILE ${SBATCH_FILE} not found in CODE_DIR ${CODE_DIR}. Can not continue.\n"
   exit 1
fi

# run the batch
export SLURM_LOG_DIR="${CODE_DIR}/logs/slurm/"
mkdir -p ${SLURM_LOG_DIR}

export CODE_LOG_DIR="${CODE_DIR}/logs/code/"
mkdir -p ${CODE_LOG_DIR}
cp $0 ${CODE_LOG_DIR}
cp "$(dirname "$0")/${SBATCH_FILE}" ${CODE_LOG_DIR} 

printf "STUDY_NAME: ${STUDY_NAME}\n"
printf "CODE_DIR: ${CODE_DIR}\n"

export HPC_NODE_NCPU=128	# Jureca has 2 x 64 core CPUs
export HPC_NODE_OMP_NTHREAD=$(($HPC_NODE_NCPU - 2)) # this is passed to qsiprep as omp, this should be < HPC_NODE_NCPU
[ $HPC_NODE_OMP_NTHREAD -lt 1 ] && export HPC_NODE_OMP_NTHREAD=1



for confound in 'TIV' 'None';do 
    for sample in 'age' 'age_TIV';do 
    

	sbatch --partition=$partition --account=${account} \
	--output=${SLURM_LOG_DIR}/%j.out \
	--error=${SLURM_LOG_DIR}/%j.err \
	--cpus-per-task=$HPC_NODE_NCPU --mem-per-cpu=${HPC_NODE_CPU_MEM} \
 	--nodes=$SLURM_JOB_NUMNODES \
	--time=${HPC_NODE_TIME} $SBATCH_FILE $sample $confound
    done
done



