module Rajz
   using DelimitedFiles
   using Plots
   tab=Array{Float64,2}
   c=Function

   function Init(dat::String)
      global tab,c
      tab=readdlm(dat);
      include("Config.jl")
      c=mcol
   end

   function uj(oname;tip,N,p,q,r,Lepes)
      global tab,c
      tmp=tab[(tab[:,c("tip")].==tip) .& (tab[:,c("Lepes")].==Lepes) .& (tab[:,c("N")].==N) .& (tab[:,c("p")].==p) .& (tab[:,c("q")].==q) .& (tab[:,c("r")].==r),:]
      mu=log.(tmp[:,c("mu")])
      mu2=log.(tmp[:,c("mu2")])
      gr()
      plot(mu,mu2,seriestype=:scatter,title=":-)",legend=false)  
      savefig(oname)
   end
   
   function regire(oname;tip,N,p,q,r,Lepes)
      global tab,c
      tmp=tab[(tab[:,c("tip")].==tip) .& (tab[:,c("Lepes")].==Lepes) .& (tab[:,c("N")].==N) .& (tab[:,c("p")].==p) .& (tab[:,c("q")].==q) .& (tab[:,c("r")].==r),:]
      mu=log.(tmp[:,c("mu")])
      mu2=log.(tmp[:,c("mu2")])
      gr()
      plot!(mu,mu2,seriestype=:scatter,title=":-)",legend=false)  
      savefig(oname)
   end

end