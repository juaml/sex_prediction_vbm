source ./code/.venv/bin/activate
export OMP_NUM_LIMIT=10
export MKL_NUM_THREADS=10
python3 $@
deactivate
