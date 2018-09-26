module Rajz
   using DelimitedFiles
   using Plots
   tab=Array{Float64,2}
   id=Any
   function Init(dat::String)
      global tab,id
      tab=readdlm(dat);
      include("Config.jl")
   end
   function uj(oname;tip,N,p,q,r,Lepes)
      tmp=tab[(tab[:,_tip].==tip) .& (tab[:,_nL].==Lepes) .& (tab[:,_N].==N) .& (tab[:,_p].==p) .& (tab[:,_q].==q) .& (tab[:,_r].==r),:]
      mu=log.(tmp[:,_mu])
      mu2=log.(tmp[:,_mu2])
      gr()
      plot(mu2,mu,seriestype=:scatter,title=":-)",legend=false)  
      savefig(oname)
   end
   function regire(oname;tip,N,p,q,r,Lepes)
      tmp=tab[(tab[:,_tip].==tip) .& (tab[:,_nL].==Lepes) .& (tab[:,_N].==N) .& (tab[:,_p].==p) .& (tab[:,_q].==q) .& (tab[:,_r].==r),:]
      mu=log.(tmp[:,_mu])
      mu2=log.(tmp[:,_mu2])
      gr()
      plot!(mu2,mu,seriestype=:scatter,title=":-)",legend=false)  
      savefig(oname)
   end

end