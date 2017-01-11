#!/bin/bash -l
#PBS -q qtest
#PBS -l nodes=1:ppn=24
#PBS -l walltime=00:10:00
 
#module load python/2.7.3 mpi4py
cd $PBS_O_WORKDIR
mpirun -np 8 mwrapper.py $PBS_O_WORKDIR/pyMPI/catAllFastq.sh