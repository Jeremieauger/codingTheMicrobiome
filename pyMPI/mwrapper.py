#!/usr/bin/env python
from mpi4py import MPI
from subprocess import call
import sys
exctbl = sys.argv[1]
comm = MPI.COMM_WORLD
rank = comm.Get_rank()
myDir = "dir"+str(rank).zfill(2)
cmd = "cd "+myDir+" ; "+exctbl+" < infile > outfile"
sts = call(cmd,shell=True)
comm.Barrier()
