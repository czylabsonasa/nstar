module User
   export p,q,r,N,ism,chkpts,maxL,outfilename,dlim
   
   # parameters of the model:
   #p,q,r = 0.98, 0.98, 0.98  
   p,q,r = 0.67525034, 0.1, 0.67525034  
   # p,q,r = 0.997, 0.1, 0.997 #
   # p,q,r = 0.995, 0.1, 0.995 #
   # p,q,r=0.6,0.6,0.6 # evolving
   N=4 # size of stars


   # parameters of simulation (generation):

   # number of repeats (e.g. num of different graphs generated)
   ism=1 
   
   # checkpoints at which the graph will be examined, 
   # the last one is the num. of steps taken at each repetition 
   # (NOT num. of vertices (which is a r.v.))
#   chkpts=[1000 10000 100000 1000000 10000000 ]# 100000000]
   chkpts=[10000000]

   # max number of steps
   maxL=chkpts[end]

   # file name for the results
   outfilename="result.dat"

   # threshold: we need at least 'dlim' different B-weights for a fixed A-weight
   dlim=2 
end
