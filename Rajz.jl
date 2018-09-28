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

   function uj(oname;_tip,_N,_p,_q,_r,_Lepes)
      global tab

      tmp=tab[(tab[:,Itip].==_tip) .& (tab[:,ILepes].==_Lepes) .& (tab[:,IN].==_N) .& (tab[:,Ip].==_p) .& (tab[:,Iq].==_q) .& (tab[:,Ir].==_r),:]
      mu=log.(tmp[:,Imu])
      mu2=log.(tmp[:,Imu2])
      gr()
      ptit="N, p, q, r, step = $(_N), $(_p), $(_q), $(_r), $(_Lepes)\n"
      if 1==_tip
         ptit=ptit*"central weight fixed"
      else
         ptit=ptit*"peripheral weight fixed"
      end
      plot(mu,mu2,seriestype=:scatter,title=ptit,legend=false,markersize=1)  
      xlabel!(L"\log(E)")
      ylabel!(L"\log(M)")

      if 1==_tip 
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