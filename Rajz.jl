module Rajz
   using DelimitedFiles
   using Plots
   tab=Array{Float64,2}
   function Init(dat::String)
      global tab
      tab=readdlm(dat);
   end
   function uj(oname;tip,N,p,q,r,Lepes)
      tmp=tab[(tab[:,1].==tip) .& (tab[:,6].==Lepes) .& (tab[:,7].==N) .& (tab[:,8].==p) .& (tab[:,9].==q) .& (tab[:,10].==r),:]
      mu=log.(tmp[:,3])
      mu2=log.(tmp[:,4])
      gr()
      plot(mu2,mu,seriestype=:scatter,title=":-)",legend=false)  
      savefig(oname)
   end
   function regire(oname;tip,N,p,q,r,Lepes)
      tmp=tab[(tab[:,1].==tip) .& (tab[:,6].==Lepes) .& (tab[:,7].==N) .& (tab[:,8].==p) .& (tab[:,9].==q) .& (tab[:,10].==r),:]
      mu=log.(tmp[:,3])
      mu2=log.(tmp[:,4])
      gr()
      plot!(mu2,mu,seriestype=:scatter,title=":-)",legend=false)  
      savefig(oname)
   end

end