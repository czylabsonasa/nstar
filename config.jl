# make it reproducible
# srand( 1080 )

# inspected graph sizes, repeat:
minpw, maxpw, ism = 20, 21, 1
rang = [ 2^i for i in ( minpw : maxpw ) ];
rang[ 1 ] = 1

# parameters of model:
N, maxL = 4, 2^maxpw
p, q, r = 0.4, 0.4, 0.4

# controlling ifub:
tol, maxnob = 2, max( 10*maxpw, 100 )
