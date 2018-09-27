module Rajz
   using DelimitedFiles
   using Plots
   using LaTeXStrings


   include("Dev.jl")
   using .Dev

   tab=Array{Float64,2}

   function Init(dat::String)
      global tab
      tab=readdlm(dat);
   end

   function uj(oname;tip,N,p,q,r,Lepes)
      global tab

      tmp=tab[(tab[:,Itip].==tip) .& (tab[:,ILepes].==Lepes) .& (tab[:,IN].==N) .& (tab[:,Ip].==p) .& (tab[:,Iq].==q) .& (tab[:,Ir].==r),:]
      mu=log.(tmp[:,Imu])
      mu2=log.(tmp[:,Imu2])
      gr()
      ptit="N, p, q, r, step = $(N), $(p), $(q), $(r), $(Lepes)\n"
      if 1==tip
         ptit=ptit*"central weight fixed"
      else
         ptit=ptit*"peripheral weight fixed"
      end
      plot(mu,mu2,seriestype=:scatter,title=ptit,legend=false,markersize=1)  
      xlabel!(L"\log(\mu)")
      ylabel!(L"\log(\mu_2)")

      if 1==tip 
         oname="c"*oname
      else
         oname="p"*oname
      end
      savefig(oname)
   end
   
   function regire(oname;tip,N,p,q,r,Lepes)
      global tab

      tmp=tab[(tab[:,Itip].==tip) .& (tab[:,ILepes].==Lepes) .& (tab[:,IN].==N) .& (tab[:,Ip].==p) .& (tab[:,Iq].==q) .& (tab[:,Ir].==r),:]
      mu=log.(tmp[:,Imu])
      mu2=log.(tmp[:,Imu2])
      gr()
      plot!(mu,mu2,seriestype=:scatter,title=":-)",legend=false)  
      savefig(oname)
   end

end