module Out
   using DelimitedFiles
   include("User.jl")
   using .User

   of=IO
   function Init()
      global of
      of=open(outfilename,"w")
   end
   function Write(akt::Array{Float64})
      global of
      writedlm(of,akt)
   end
   function Finish()
      global of
      close(of)
   end
end
