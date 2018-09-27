include("Rajz.jl")
using .Rajz
Rajz.Init("output")


for i in 3:7
   Rajz.uj("$(i)"*".pdf";tip=1,N=6,Lepes=10^i,p=0.5,q=0.5,r=0.5)   
end
