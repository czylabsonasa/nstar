# user defined parameters of the model:
p,q,r=0.5,0.5,0.5 # evolving
N=4 # size of stars

# parameters of simulation
ism=1 # number of repeats (e.g. num of different graphs generated)
chkpts=[1000 10000 100000 1000000 10000000] # checkpoints at which the graph will be examined, 
                 # the last one is the num. of steps taken at each repetition (NOT num. of vertices)

dlim=5 # threshold: we need at least 'dlim' different B-weights for a fixed A-weight
# output="output" # file for results

function mcol(s::String)
   while true
      if(s=="tip") return 1 end
      if(s=="w") return 2  end
      if(s=="mu") return 3 end
      if(s=="mu2") return 4 end
      if(s=="nV") return 5 end
      if(s=="Lepes") return 6 end
      if(s=="N") return 7 end
      if(s=="p") return 8 end
      if(s=="q") return 9 end
      if(s=="r") return 10 end
      break
   end
   return -1
end
