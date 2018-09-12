__precompile__()

module Nstar

   maxL,N,nV=0,0,0
   L=Matrix{Int}
   akt=Vector{Int}
   p,q,r=0.0,0.0,0.0

   function Init()
      global maxL,N,nV,L,p,q,r,akt
      include( "User.jl" )
      maxL=chkpts[end] # maxL: number of steps (incl. first one)
      L=Matrix{Int}(undef,maxL,N) # the array of generated stars
      nV=0 # num of vertices
      akt=Vector{Int}(undef,N)
   println(N," ",p," ",q," ",r," ")
   end

   # the first step
   function Step1()
      global N,nV,L
      L[1,:]=1:N
      nV=N
   end

   # uniform sample from the possible stars
   # fills the array startin from i
   function sampleIt(i::Int)
      global N,nV,akt
      while i<=N
         v=rand(1:nV)
         if !(v in akt[1:(i-1)])
            akt[i]=v
            i+=1
         end
      end
   end

   function Step(lo::Int,up::Int)
      global N,nV,L,p,q,r,akt
      while lo<up
         lo+=1
         if rand()<p # new vertex
            nV+=1
            if rand()<r # PA choose from old (small,N-1) stars
               #  println("pr")
               akt=L[rand(1:(lo-1)),:]
               akt[rand(2:N)]=nV
            else
            #   println("p(1-r)")
               akt[1]=nV
               sampleIt(2)
               akt[N],akt[1]=akt[1],akt[N]
            end
         else
            if rand()<q # PA from old (big,N) stars
            #     println("(1-p)q")
               akt=L[rand(1:(lo-1)),:]
            else
            #    println("(1-p)(1-q)")
               sampleIt(1)
            end
         end
         L[lo,:]=akt
         #println(L[lo,:])
      end
   end  # of Step


end # of module Nstar