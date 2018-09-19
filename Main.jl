const deb=false

include("Nstar.jl")
using .Nstar

include("Sim.jl")
using .Sim

include("Proci.jl")
using .Proci

include("Out.jl")
using .Out



Nstar.Init()
Sim.Init()
Proci.Init(Nstar.maxL,Out.Write)
Out.Init("output")

# uncomment the next row and adjust the parameter to get a "deterministic" graph
# srand( 1080 )

# println("nV=",Nstar.nV)
sbeg=time_ns()
for rep in 1:Sim.ism
   beg=time_ns()
   Nstar.Step1()
   psiz=1
   print(rep,": ")
   for siz in Sim.chkpts
      print(" (",siz)
      Nstar.Step(psiz,siz) # steps: from psiz+1 to siz
      Proci.proc(Nstar.W,Nstar.nV,siz,1)
      Proci.proc(Nstar.W,Nstar.nV,siz,2)
      psiz=siz
      print(") ")
   end
   println(".........",(time_ns()-beg)/1e9," sec")
end

Out.Finish()

println("Sim: ",(time_ns()-sbeg)/1e9," sec")

deb ? for i in 1:Nstar.nV
   println(Nstar.W[i,:])
end : nothing