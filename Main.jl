# controls debug messages:
const deb=false
let
  function Start(s::String)
    print(s)
    time_ns()
  end
  function Stop(t)
    println("done in ",(time_ns()-t)/1e9," sec\n")
  end

#  @goto csakrajz

  t1=Start("\n\nInits...\n")

  include("Nstar.jl")
  using .Nstar

  include("Process.jl")
  using .Process

  include("Out.jl")
  using .Out

  include("User.jl")
  using .User:ism,chkpts

  Nstar.Init()
  Process.Init(Nstar.maxL,Out.Write)
  Out.Init()

  Stop(t1)


  # uncomment the next row and adjust the parameter to get a "deterministic" graph
  # srand( 1080 )

  t1=Start("\n\nGeneration...\n")
  sbeg=time_ns()
  for rep in 1:ism
    beg=time_ns()
    Nstar.Step1()
    psiz=1
    t2=Start(" Ism=$(rep)...")
    for siz in chkpts
        Nstar.Step(psiz,siz) # steps: from psiz+1 to siz
        Process.Proc(Nstar.W,Nstar.nV,siz,1)
        Process.Proc(Nstar.W,Nstar.nV,siz,2)
        psiz=siz
    end
    Stop(t2)
  end

  Out.Finish()

  Stop(t1)

#  @label csakrajz
  t1=Start("\n\nPlotting...")
  include("Rajz.jl")
  Rajz.Init()
  Rajz.AllPlot()
  Stop(t1)
end