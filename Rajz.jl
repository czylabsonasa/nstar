module Rajz
  using DelimitedFiles
  using Plots
  using LaTeXStrings
  using Printf


  include("User.jl")
  using .User

  include("Dev.jl")
  using .Dev

  include("Reg.jl")
  using .Reg

  cnf=Dict("seriestype"=>:scatter, "markercolor"=>:blue, "markersize"=>2,"markershape"=>:circle, "markerstrokecolor"=>:blue)
  tab=Array{Float64,2}
  function Init()
    global tab
    tab=readdlm(outfilename);
  end

  function OnePlot(oname;_tip,_Lepes)
    global tab

    tmp=tab[(tab[:,Itip].==_tip) .& (tab[:,ILepes].==_Lepes) .& (tab[:,IN].==N) .& (tab[:,Ip].==p) .& (tab[:,Iq].==q) .& (tab[:,Ir].==r),:]
    mu=log.(tmp[:,Imu])
    mu2=log.(tmp[:,Imu2])
    gr()
    ptit="N, p, q, r, step = $(N), $(p), $(q), $(r), $(_Lepes)\n"
    if 1==_tip
        ptit=ptit*"central weight fixed"
    else
        ptit=ptit*"peripheral weight fixed"
    end
    Reg.reg(mu,mu2,Float64(_tip),Float64(_Lepes))


#    plot(mu,mu2,seriestype=cnf["seriestype"],markercolor=:lightblue,title=ptit,legend=false,markersize=2,markershape=:circle)  
    plot(mu,mu2,seriestype=cnf["seriestype"],markercolor=cnf["markercolor"],title=ptit,legend=false,markersize=cnf["markersize"],markershape=cnf["markershape"], markerstrokecolor=cnf["markerstrokecolor"])  

    xlabel!(L"\log(E)")
    ylabel!(L"\log(M)")

    if 1==_tip 
        oname="c"*oname
    else
        oname="p"*oname
    end
    savefig(oname)
  end

  function AllPlot()
    for siz in chkpts
        e=Int(ceil(log(siz)/log(10.0)))
        oname=@sprintf("%.1fe%d",siz/(10^e),e)
        OnePlot(oname*".pdf";_tip=1,_Lepes=siz)   
    end

    for siz in chkpts
        e=Int(ceil(log(siz)/log(10.0)))
        oname=@sprintf("%.1fe%d",siz/(10^e),e)
        OnePlot(oname*".pdf";_tip=2,_Lepes=siz)   
    end
    Reg.Finish()
  end

  # function regire(oname;tip,N,p,q,r,Lepes)
  #    global tab

  #    tmp=tab[(tab[:,Itip].==tip) .& (tab[:,ILepes].==Lepes) .& (tab[:,IN].==N) .& (tab[:,Ip].==p) .& (tab[:,Iq].==q) .& (tab[:,Ir].==r),:]
  #    mu=log.(tmp[:,Imu])
  #    mu2=log.(tmp[:,Imu2])
  #    gr()
  #    plot!(mu,mu2,seriestype=:scatter,title=":-)",legend=false)  
  #    savefig(oname)
  # end

end