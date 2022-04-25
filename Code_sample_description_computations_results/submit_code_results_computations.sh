#!/bin/sh
# v3.0

logs_dir=/data/project/transgender_replication/Code_sample_description_results_computations_LW_local_clean/log
# create the logs dir if it doesn't exist
[ ! -d "$logs_dir" ] && mkdir -p "$logs_dir"

# print the .submit header
printf "# The environment
universe       = vanilla
getenv         = True
request_cpus   = 1
request_memory = 2G

# Execution
requirements = Machine == \"cpu10.htc.inm7.de\" || Machine == \"cpu11.htc.inm7.de\"
initial_dir    = /data/project/transgender_replication/Code_sample_description_results_computations_LW_local_clean/
transfer_executable = False
executable     = /usr/bin/matlab94
\n"
	
# create a job
printf "arguments = -singleCompThread -r Script_00_define_input_call_functions\n"
printf "log            = ${logs_dir}/Computation_results.log\n"
printf "output         = ${logs_dir}/Computation_results.out\n"
printf "error          = ${logs_dir}/Computation_results.err\n"
printf "Queue\n\n"
