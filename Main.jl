# controls debug messages:
const deb=false

include("Nstar.jl")
using .Nstar

include("Process.jl")
using .Process

include("Out.jl")
using .Out

include("User.jl")
using .User:ism,chkpts



Nstar.Init()
Process.Init(Nstar.maxL,Out.Write)
Out.Init()

# uncomment the next row and adjust the parameter to get a "deterministic" graph
# srand( 1080 )

# println("nV=",Nstar.nV)
sbeg=time_ns()
for rep in 1:ism
   beg=time_ns()
   Nstar.Step1()
   psiz=1
   print(rep,": ")
   for siz in chkpts
      print(" (",siz)
      Nstar.Step(psiz,siz) # steps: from psiz+1 to siz
      Process.Proc(Nstar.W,Nstar.nV,siz,1)
      Process.Proc(Nstar.W,Nstar.nV,siz,2)
      psiz=siz
      print(") ")
   end
   println(".........",(time_ns()-beg)/1e9," sec")
end

Out.Finish()

println("Sim: ",(time_ns()-sbeg)/1e9," sec")


sbeg=time_ns()
print("Plotting...")
include("Rajz.jl")
Rajz.Init()
Rajz.AllPlot()
println("done in ",(time_ns()-sbeg)/1e9," sec")




# include("Rajz.jl")
# using .Rajz
# Rajz.Init("output")
# for i in 3:7
#    Rajz.uj("$(i)"*".pdf";tip=1.0,N=4.0,Lepes=10.0^i,p=0.5,q=0.5,r=0.5)   
# end
