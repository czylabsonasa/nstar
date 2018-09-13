module Stati
   frek=Vector{Int}
   function Init(maxL::Int)
      global frek
      frek=Vector{Int}(undef,maxL+1)
   end
   function proc(W::Matrix{Int},nV::Int,nL::Int)
      global frek
      maxw1=maximum(W[1,:]);
      for w1 in 0:maxw1
         maxw2=0
         nw1=0
         for i in 1:nV
            W[i,1]==w1 || continue
            nw1+=1
            W[i,2]>0 || continue
            frek[W[i,2]]+=1
            maxw2=max(maxw2,W[i,2])
         end
         if nw1>0
            mu=0.0
            mu2=0.0
            for i in 1:maxw1
               mu+=i*frek[i];
               mu2+=i*i*frek[i];
               frek[i]=0
            end
            mu/=nw1
            mu2/=nw1
            if mu2>0
               println(nV," ",nL," ",w1," ","-1 ",mu," ",mu2," ",(mu*mu)/mu2)
            else
               println(nV," ",nL," ",w1," ","-1 ",mu," ",mu2," 1")
            end
         end
      end
   end
end