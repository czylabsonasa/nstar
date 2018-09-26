# user defined parameters of the model:
p,q,r=0.5,0.5,0.5 # evolving
N=4 # size of stars

# parameters of simulation
ism=1 # number of repeats (e.g. num of different graphs generated)
chkpts=[1000 10000 100000 1000000 10000000] # checkpoints at which the graph will be examined, 
                 # the last one is the num. of steps taken at each repetition (NOT num. of vertices)

dlim=5 # threshold: we need at least 'dlim' different B-weights for a fixed A-weight
# output="output" # file for results

@enum id begin
   _tip=1
   _w=2
   _mu=3
   _mu2=4
   _nV=5
   _nL=6
   _N=7
   _p=8
   _q=9
   _r=10
end
