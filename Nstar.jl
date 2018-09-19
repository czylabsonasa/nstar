# __precompile__()

module Nstar
   const deb=false

   maxL,N,nV=0,0,0
   L=Matrix{Int}
   W=Matrix{Int} # weights handled during generation
   akt=Vector{Int}
   p,q,r=0.0,0.0,0.0

   function Init()
      global maxL,N,nV,L,p,q,r,akt,W
      include( "Config.jl" )
      maxL=chkpts[end] # maxL: number of steps (incl. first one)
      L=Matrix{Int}(undef,maxL,N) # the array of generated stars
      W=Matrix{Int}(undef,maxL,2) # weights
      nV=0 # num of vertices
      akt=Vector{Int}(undef,N)
deb ? println("Nstar.Init: ",N," ",p," ",q," ",r," ",maxL) : nothing
   end

   # the first step
   function Step1()
      global N,nV,L,W
      L[1,:]=1:N
      nV=N
      W[1,:]=[1,0]
      W[2:N,1],W[2:N,2]=zeros(Int,N-1,1),ones(Int,N-1,1)
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
      global N,nV,L,p,q,r,akt,W,nodeb
      while lo<up
         lo+=1
         if rand()<p # new vertex
            nV+=1
            W[nV,:]=[0,0]
            if rand()<r # PA choose from old (small,N-1) stars
deb ? print("pr         ") : nothing
               akt=L[rand(1:(lo-1)),:]
               akt[rand(2:N)]=nV
            else
deb ? print("p(1-r)     ") : nothing
               akt[1]=nV
               sampleIt(2)
               akt[N],akt[1]=akt[1],akt[N]
            end
         else
            if rand()<q # PA from old (big,N) stars
deb ? print("(1-p)q     ") : nothing
               akt=L[rand(1:(lo-1)),:] 
            else
deb ? print("(1-p)(1-q) ") : nothing
               sampleIt(1)
            end
         end
         L[lo,:]=akt
         W[akt[1],1]+=1
         for i in 2:N
            W[akt[i],2]+=1
         end
Nstar.deb ? println(L[lo,:]) : nothing
      end
   end  # of Step


end # of module Nstar