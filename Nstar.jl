module Nstar
   const deb=false
   include("User.jl")
   using .User
#   export Init,Step1,Step

   nV=Int
   L=Array{Int,2}
   W=Array{Int,2} # weights handled during generation
   akt=Array{Int,1}

   function Init()
      global nV,L,akt,W
      nV=0 # num of vertices
      L=fill(0,maxL,N) # the array of generated stars
      W=fill(0,maxL+N,2) # weights
      akt=fill(0,1,N)
   end

   # the first step
   function Step1()
      global nV,L,W
      L[1,:]=1:N
      nV=N
      W[1,:]=[1,0]
      W[2:N,1],W[2:N,2]=zeros(Int,N-1,1),ones(Int,N-1,1)
   end

   # uniform sample from the possible stars
   # fills the array startin from i
   function sampleIt(i::Int)
      global nV,akt
      while i<=N
         v=rand(1:nV)
         if !(v in akt[1:(i-1)])
            akt[i]=v
            i+=1
         end
      end
   end

   function Step(lo::Int,up::Int)
      global nV,L,akt,W,deb
      while lo<up
         lo+=1
         if rand()<p # new vertex
            if rand()<r # PA choose from old (small,N-1) stars
deb ? print("pr         ") : nothing
               akt=L[rand(1:(lo-1)),:]
               akt[rand(2:N)]=nV+1
            else
deb ? print("p(1-r)     ") : nothing
               akt[1]=nV+1
               sampleIt(2)
               # akt[N],akt[1]=akt[1],akt[N]
            end
            nV+=1
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
