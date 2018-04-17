include( "config.jl" )

using LightGraphs
include( "Nstar.jl" )
d = nsInit( N, maxL, p, q, r )

maxV = maxL  # upper bound for max of vertices
include( "Ifub.jl" )
ifub = preifub( tol, maxnob )


td = Dict( d )
tic()
for rep in 1:ism
println( "-----------------\n" )
   nsStep1( td )
   Step = nsStep( td )
   for i in ( 2 : ( maxpw - minpw + 1 ) )
      G = Step( rang[ i - 1 ], rang[ i ] ) # step=rang[i-1]+1...rang[i]
      nV = nv( G )
      fill!( eccU, nV )
      n2d = [ [ i; degree( G, i ) ] for i in 1 : nV ]
      sort!( n2d, by = x -> -x[ 2 ] )


      L, U = 1, nV
      allnob = 0
      cancel = 0
      rit = 1
      while rit <= nV # !!!
         root = n2d[ rit ][ 1 ]
         if eccU[ root ] > L
            s2L, _, _ = sweep2( G, root )
println( "   sweep2... L = ", s2L )

            sNL, sNnob = sweepN( G, root )
println( "   sweepN... L = ", sNL, " nob = ", sNnob )


            L, U, nob = ifub( G, root, L, U )
println( "   progress... L,U = ", L, " ", U )
            allnob += nob
            if L + tol >= U
               break
            end
            if allnob > round(minpw^(5/2)) # O(log(nV)^2)
               break
            end
         else
            cancel += 1
         end

         rit = rit + 1
      end
#~       println("max eccU: ", maximum(eccU[1:nV]))
#~       println("frek = ", frek)
#~       println("eccU: ", eccU[1:nV])
#~       println(frek)

      println( "L,U = ", L, " ", U )
      println("max eccU = ", maximum(eccU[1:nV]))
      print( "nV = ", nV, " step = ", rang[ i ] )
      println( "              p,q,r = ", p, " ", q, " ", r )
      println( "it = ", rit, " canceled = " , cancel )
      println( "allnob =  ", allnob )



#      if nV < 3000
#         print( " (", diameter( G ) , ")" )
#      end

   end
end
toc()
