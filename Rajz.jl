module Rajz
   using DelimitedFiles
   using Plots
   tab=Array{Float64,2}
   Itip,Iw,Imu,Imu2,InV,ILepes,IN,Ip,Iq,Ir=1:10
   

   function Init(dat::String)
      global tab,Itip,Iw,Imu,Imu2,InV,ILepes,IN,Ip,Iq,Ir

      tab=readdlm(dat);
      include("Config.jl")
   end

   function uj(oname;tip,N,p,q,r,Lepes)
      global tab,Itip,Iw,Imu,Imu2,InV,ILepes,IN,Ip,Iq,Ir

      tmp=tab[(tab[:,Itip].==tip) .& (tab[:,ILepes].==Lepes) .& (tab[:,IN].==N) .& (tab[:,Ip].==p) .& (tab[:,Iq].==q) .& (tab[:,Ir].==r),:]
      mu=log.(tmp[:,Imu])
      mu2=log.(tmp[:,Imu2])
      gr()
      plot(mu,mu2,seriestype=:scatter,title=":-)",legend=false)  
      savefig(oname)
   end
   
   function regire(oname;tip,N,p,q,r,Lepes)
      global tab,Itip,Iw,Imu,Imu2,InV,ILepes,IN,Ip,Iq,Ir

      tmp=tab[(tab[:,Itip].==tip) .& (tab[:,ILepes].==Lepes) .& (tab[:,IN].==N) .& (tab[:,Ip].==p) .& (tab[:,Iq].==q) .& (tab[:,Ir].==r),:]
      mu=log.(tmp[:,Imu])
      mu2=log.(tmp[:,Imu2])
      gr()
      plot!(mu,mu2,seriestype=:scatter,title=":-)",legend=false)  
      savefig(oname)
   end

end