p       <- 2                     # numero de variaveis
n       <- 4                     # tamanho da amostra
X       <- matrix(0,p,n)         # definindo X
X[1, ]  <- c( 4,  5,  4,  3)     # valores de X_{1i}
X[2, ]  <- c(42, 52, 48, 58)     # valores de X_{1i}
ones    <- matrix(1,n,1)         # vetor de uns
xbar    <- (X%*%ones) / n        # vetor de medias
sdX     <- apply(X,1,"sd")       # d. padrao das variaveis
D.half  <- diag(sdX,p,p)         # matriz Delta^{1/2}
X.xbar  <- X-xbar%*%t(ones)      # matriz (X - xbarra*ones')
W       <- X.xbar%*%t(X.xbar)    # somas dos desvios ao 
                                 # quadrados e cruzados
S       <- W/(n-1)               # matriz de covariancias
ID.half <- solve(D.half)         # matriz Delta^{-1/2}
R       <- ID.half%*%S%*%ID.half # matriz de correlacoes

xbar # vetor de medias 
S    # matriz de covariancias
R    # matriz de correlacoes

apply(X,1,"mean") # vetor (linha) de medias 
var(t(X))         # matriz de covariancias  
cor(t(X))         # matriz de correlacoes
# IMPORTANTE: note a transposicao da matriz X.