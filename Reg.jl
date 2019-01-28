module Reg
  using Statistics
  using DelimitedFiles

  of=open("reg.dat","w")
  writedlm( of, [ "tip" "Lepes" "R" "corr" "beta0" "beta1" ] )


  function reg(x,y,tip,Lepes)
    global of
    mx=mean(x)
    mx2=mean(x .*x)
    my=mean(y)
    mxy=mean(x .* y)
    beta1=(mxy-mx*my)/(mx2-mx*mx)
    beta0=my - beta1*mx
    ssT=sum( (y .- my).^2 )
    ry=beta1*x .+ beta0
    ssR=sum( (ry .- my).^2 )
    ssE=sum( (ry .- y).^2 )
    R=ssR/ssT
    writedlm(of, [ tip Lepes R cor(x,y) beta0 beta1 ])
  end

  function Finish()
    global of
    close(of)
  end
end