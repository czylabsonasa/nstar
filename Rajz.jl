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
      x=log.(tmp[:,2])
      y=log.(tmp[:,3])
      gr()
      plot(x,y,seriestype=:scatter,title=":-)",legend=false)  
      savefig(oname)
   end
   function regire(oname;tip,N,p,q,r,Lepes)
      tmp=tab[(tab[:,1].==tip) .& (tab[:,6].==Lepes) .& (tab[:,7].==N) .& (tab[:,8].==p) .& (tab[:,9].==q) .& (tab[:,10].==r),:]
      x=log.(tmp[:,2])
      y=log.(tmp[:,3])
      gr()
      plot!(x,y,seriestype=:scatter,title=":-)",legend=false)  
      savefig(oname)
   end

end