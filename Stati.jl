module Stati
   fi,fii=Vector{Int},Vector{Int}
   function Init(maxL::Int)
      global frek
      fi,fii=fill(0,maxL+1),fill(0,maxL+1)
   end
   function proc(W::Matrix{Int},nV::Int,nL::Int,const i)
      global fi,fii
      Wi=view(W,:,i)
      Wii=view(W,:,3-i)
      maxwi=0
      for it in 1:nV
         maxwi=max(maxwi,Wi[it])
         fi[W[it]+1]+=1
      end

      for wi in 0:maxwi
         fi[it+1]>0 || continue
         maxwii=0
         for iit in 1:nV
            Wi[iit]==wi || continue
            fii[Wii[iit]+1]+=1
            maxwii=max(maxwii,Wii[iit])
         end
         mu,mu2=mucomp(fii,maxwii,fi[wi+1])
         if mu2>0
            println(i," ",nV," ",nL," ",w1," ","-1 ",mu," ",mu2," ",(mu*mu)/mu2)
            else
               println(nV," ",nL," ",w1," ","-1 ",mu," ",mu2," 1")
            end
         end
      end
   end

   function mucomp(f,nf,sf)
      mu,mu2=0.0,0.0
      for it in 0:nf
         mu+=it*f[it+1]
         mu2+=it*it*f[it+1]
      end
      return mu/sf,mu2/sf
   end
end