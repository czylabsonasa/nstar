module Stati
   const deb=false
   fi,fii=Vector{Int},Vector{Int}
   function Init(maxL::Int)
      global fi,fii
      fi,fii=fill(0,maxL+1),fill(0,maxL+1)
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
         fi[wi+1]>0 || continue
         maxwii=0
         for it in 1:nV
            Wi[it]==wi || continue
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

         mu,mu2,nd=mucomp(fii,maxwii,fi[wi+1])
         # mu2-=mu*mu
         if nd<10
            continue
         end
         if mu2>0
            println(i," ",wi," ",mu," ",mu2," ",log(mu)/log(mu2)," ",nd," ",nV," ",nL)
         else
            println(i," ",wi," ",mu," ",mu2," ","?"," ",nd," ",nV," ",nL)
         end
         fi[wi+1]=0
      end
   end

   function mucomp(f,nf,sf)
      mu,mu2=0.0,0.0
      ndiff=0
      for it in 0:nf
         ( 0==f[it+1] && continue ) || (ndiff+=1)
         mu+=it*f[it+1]
         mu2+=it*it*f[it+1]
         f[it+1]=0
      end
      return mu/sf,mu2/sf,ndiff
   end
end