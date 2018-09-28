include("Rajz.jl")
using .Rajz
Rajz.Init("output")

include("User.jl")
using .User

for i in 3:7
   Rajz.uj("$(i)"*".pdf";_tip=1,_N=N,_Lepes=10^i,_p=p,_q=q,_r=r)   
end

for i in 3:7
   Rajz.uj("$(i)"*".pdf";_tip=2,_N=N,_Lepes=10^i,_p=p,_q=q,_r=r)   
end

