
function nsInit( N::Int, maxL::Int, p::Float64, q::Float64, r::Float64 )
    L = Vector{ Vector{ Int32 } }( maxL )
    for i in  1 : maxL
        L[ i ] = Vector{ Int32 }( N )
    end
    return Dict( :N => N, :maxL => maxL, :p => p,  :q => q, :r => r, :L => L )
end

function nsStep1( _d::Dict )
   G = Graph()
   L, N = _d[ :L ], _d[ :N ]
   add_vertices!( G , N )
   L1 = L[ 1 ]
   L1[ 1 ] = 1
   for i in ( 2 : N )
      L1[ i ] = Int32( i )
      add_edge!( G, 1, i )
   end
   _d[ :G ] = G

   return _d
end


function nsStep( _d::Dict )
   N, p, q, r, G, L = _d[ :N ], _d[ :p ], _d[ :q ], _d[ :r ], _d[ :G ], _d[ :L ]
   nV = nv( G )
   akt = Vector{ Int32 }( N )

   function addIt( loc :: Int )
      copy!( L[ loc ], akt )
      for i in ( 2 : N )
          add_edge!( G, Int( akt[ 1 ] ), Int( akt[ i ] ) )
      end
   end

   function sampleIt()
      i = 1
      while i < N
         v = rand( 1 : nV )
         if ! ( v in akt[ 1 : i ] )
            i += 1
            akt[ i ] = v
         end
      end
   end

   function _Step( _kezd::Int, _veg::Int )
      while _kezd < _veg
         _kezd += 1
         if rand() < p
            nV += 1
            add_vertex!( G )
            if rand() < r
                #print("pr")
                copy!( akt , L[ rand( 1 : ( _kezd - 1 ) ) ] )
                akt[ rand( 1 : N ) ] = akt[ 1 ]
                akt[ 1 ] = nV
                addIt( _kezd )
            else
                #print("p(1-r)")
                akt[ 1 ] = nV
                sampleIt()
                addIt( _kezd )
            end
         else
            if rand() < q
               #print("(1-p)q")
               copy!( akt, L[ rand( 1 : ( _kezd - 1 ) ) ] )
               addIt( _kezd )
            else
               #print("(1-p)(1-q)")
               akt[ 1 ] = rand( 1 : nV )
               sampleIt()
               addIt( _kezd )
            end
         end
      end
    #println(L)
    return G
   end # of _Step

end # of nsStep

