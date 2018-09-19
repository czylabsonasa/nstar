# user defined parameters of the model:
p,q,r=0.5,0.5,0.5 # evolving
N=4 # size of stars

# parameters of simulation
ism=2 # number of repeats (e.g. num of different graphs generated)
chkpts=[100000] # checkpoints at which the graph will be examined, 
                 # the last one is the num. of steps taken at each repetition (NOT num. of vertices)

dlim=5 # threshold: we need at least 'dlim' different B-weights for a fixed A-weight