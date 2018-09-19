module Proci
   const deb=false
   fi,fii=Vector{Int},Vector{Int}
   dlim=0
   function Init(maxL::Int)
      global fi,fii,dlim
      fi,fii=fill(0,maxL+1),fill(0,maxL+1)
      include("Config.jl")
   end
   function proc(W::Matrix{Int},nV::Int,nL::Int,i)
      global fi,fii
      Wi=view(W,:,i)
      Wii=view(W,:,3-i)
      maxwi=0
      for it in 1:nV
         wi=Wi[it]
         maxwi=max(maxwi,wi)
         fi[wi+1]+=1
      end

      for wi in 0:maxwi
         if 0==fi[wi+1]
            continue
         end
         maxwii=0
         for it in 1:nV
            if Wi[it]!=wi
               continue
            end
            wii=Wii[it]
            fii[wii+1]+=1
            maxwii=max(maxwii,wii)
         end

deb ? if 1==wi%10
   for it in 0:maxwii
      print(fii[it+1]," ")
   end
   println();
end : nothing

         mu,mu2,nd=mucomp(fii,maxwii,fi[wi+1]) # nd: num of diff ii weights that  size of the wi-abundance
         # mu2-=mu*mu
         if nd>=dlim
            if mu2>0
               println(i," ",wi," ",mu," ",mu2," ",log(mu)/log(mu2)," ",nd," ",nV," ",nL)
            else
               println(i," ",wi," ",mu," ",mu2," ","?"," ",nd," ",nV," ",nL)
            end
         end
         fi[wi+1]=0
      end
   end

   function mucomp(f,nf,sf)
      mu,mu2=0.0,0.0
      s=0
      ndiff=0
      for v in 0:nf
         fv=f[v+1]
         if 0==fv
            continue 
         end
         ndiff+=1
         mu+=v*fv
         mu2+=v*v*fv
         s+=fv
         f[v+1]=0
      end
s!=sf ? throw(DomainError("s!=sf")) : nothing
      return mu/sf,mu2/sf,ndiff
   end
end