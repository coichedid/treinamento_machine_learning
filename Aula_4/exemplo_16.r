# rm(list=ls())
#====================================================
# Exemplo para gerar de uma normal truncada entre 0 e
# infinito pelo metodo da rejeicao utilizando 
# proposta Gama(1,1)=Exp(1)
#====================================================
set.seed(12345)
n  <- 100000 # Tamanho da amostra

#====================================================
# Gerando de uma proposta Exp(1)

# O valor que maxima a aceitacao para Exp(1) e'
C  <- 2*dnorm(1)/dexp(1,1)
C
x  <- rep(NA,n)
k  <- 0
v  <- 0
while(k<=n){
	v <- v+1
	w  <- rexp(1,1)
	prob <- 2*dnorm(w)/( C*dexp(w,1) )
#	if( rbinom(1,1,prob) ){
	if( runif(1) < prob ){
		k    <- k+1
		x[k] <- w
	}
}

# taxa de aceitacao empirica
 n / v

x11()
hist(x,nclass=50,prob=T,main="",cex.axis=2,cex.lab=2,col="darkgreen")
xseq <- seq(0,5,length=1000)
yseq <- 2*dnorm(xseq)
lines(xseq,yseq,col=2,lwd=3)

#====================================================
# Fim
#====================================================

