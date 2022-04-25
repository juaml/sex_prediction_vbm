#!/bin/sh
# v3.0

logs_dir=/data/project/transgender_replication/data/Code_Create_transgender_input_Barcelona_LW/log
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
initial_dir    = /data/project/transgender_replication/data/Code_Create_transgender_input_Barcelona_LW/
transfer_executable = False
#executable     = /usr/bin/matlab90
executable     = /usr/bin/matlab95
\n"
	
# create a job
printf "arguments = -singleCompThread -r Script_00_define_input_paths_call_functions\n"
printf "log            = ${logs_dir}/Create_model_input_Barcelona_transgender_data.log\n"
printf "output         = ${logs_dir}/Create_model_input_Barcelona_transgender_data.out\n"
printf "error          = ${logs_dir}/Create_model_input_Barcelona_transgender_data.err\n"
printf "Queue\n\n"
