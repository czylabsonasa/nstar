__precompile__()
# todo: Dict+Write (?)
module Out
   using DelimitedFiles
   output=""
   of=IO
   function Init()
      global output,of
      include("Config.jl")
      of=open(output,"a")
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
