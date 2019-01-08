module User
   export p,q,r,N,ism,chkpts,maxL,outfilename,dlim
   
   # parameters of the model:
   p,q,r=0.6,0.6,0.6 # evolving
   N=4 # size of stars


   # parameters of simulation (generation):

   # number of repeats (e.g. num of different graphs generated)
   ism=1 
   
   # checkpoints at which the graph will be examined, 
   # the last one is the num. of steps taken at each repetition (NOT num. of vertices)
   chkpts=[1000 10000 100000 1000000 10000000 200000000]
   
   # max number of steps
   maxL=chkpts[end]

   # file name for the results
   outfilename="result.dat"

   # threshold: we need at least 'dlim' different B-weights for a fixed A-weight
   dlim=2 
end
