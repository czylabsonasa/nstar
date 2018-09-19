const deb=false

include("Nstar.jl")
using .Nstar

include("Sim.jl")
using .Sim

include("Stati.jl")
using .Stati


Nstar.Init()
Sim.Init()
Stati.Init(Nstar.maxL)

# uncomment the next row and adjust the parameter to get the same graph for diff. runs
# srand( 1080 )

# println("nV=",Nstar.nV)

for rep in 1:Sim.ism
   println( "-----------------\n" )
   Nstar.Step1()
   psiz=1
   for siz in Sim.chkpts
      Nstar.Step(psiz,siz) # steps: from psiz+1 to siz
      Stati.proc(Nstar.W,Nstar.nV,siz,1)
#      Stati.proc(Nstar.W,Nstar.nV,siz,2)
      psiz=siz
   end
end

#println("Elapsed time: ",(time_ns()-beg)/1e9," sec")
deb ? for i in 1:Nstar.nV
   println(Nstar.W[i,:])
end : nothing