# user defined parameters of the model:
p,q,r=0.1,0.1,0.1 # evolving
N=4 # size of stars

# parameters of simulation
ism=3 # number of repeats (e.g. num of different graphs generated)
chkpts=[1000000] # checkpoints at which the graph will be examined, 
                 # the last one is the num. of steps taken at each repetition (NOT num. of vertices)
