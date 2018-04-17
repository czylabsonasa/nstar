# make it reproducible
srand( 108 )

# inspected graph sizes, repeat:
minpw, maxpw, ism = 14, 15, 2
rang = [ 2^i for i in ( minpw : maxpw ) ];
rang[ 1 ] = 1

# parameters of model:
N, maxL = 4, 2^maxpw
p, q, r = 0.5, 0.5, 0.5

# controlling ifub:
tol, maxnob = 1, 100
