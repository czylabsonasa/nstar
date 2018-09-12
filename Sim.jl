__precompile__()
module Sim
   ism=0
   chkpts=Vector{Int}
   function Init()
      global ism,chkpts
      include( "User.jl" )
   end
end