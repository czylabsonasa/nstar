module Stati
   frek=Array{Int,2}
   function Init(maxL::Int)
      global frek
      frek=fill(0,maxL+1,2)
   end
   function pre(W::Matrix{Int},nV::Int,nL::Int,const i::Int)
      global frek
      fi=view(frek,:,i);
      Wi=view(W,:,i);
      fii=view(frek,:,3-i);
      Wii=view(W,:,3-i);

      maxwi=0
      for it in 1:nV
         maxwi=max(Wi[it],maxwi)
         fi[Wi[it]+1]+=1
      end

      for wi in 0:maxwi
         nwi=fi[wi+1]
         if 0==nwi 
            continue
         end

         maxwii=0
         for it in 1:nV
            Wi[it]==wi || continue
            fii[Wii[it]+1]+=1
            maxwii=max(maxwii,Wii[it])
         end
         mu,mu2=desc(fii,maxwii);
         mu/=nwi
         mu2/=nwi

         print(i," ",nV," ",nL," ",wi," ",mu," ",mu2)
         if mu2>0
            println(" ",(mu*mu)/mu2)
         else
            println(" 1")
         fi[wi+1]=0
      end
   end

   function desc(f,nf)
      mu=0.0
      mu2=0.0
      for i in 1:nf
         mu+=i*f[i+1];
         mu2+=i*i*f[i+1];
         frek[i]=0
      end
   end
end