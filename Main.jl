include("Nstar.jl")
using .Nstar

include("Sim.jl")
using .Sim

include("Stati.jl")
using .Stati


Nstar.Init()
Sim.Init()
Stati.Init(Nstar.maxL)

# uncomment the next row and adjust the parameter to get a fixed graph
# srand( 1080 )

println("nV=",Nstar.nV)

for rep in 1:Sim.ism
   println( "-----------------\n" )
   Nstar.Step1()
   psiz=1
   for siz in Sim.chkpts
      Nstar.Step(psiz,siz) # 
      Stati.proc(Nstar.W,Nstar.nV,siz)
      psiz=siz
   end
end

#println("Elapsed time: ",(time_ns()-beg)/1e9," sec")
Nstar.deb ? for i in 1:Nstar.nV
   println(Nstar.W[i,:])
end : nothing