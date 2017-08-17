# rm(list=ls())
#====================================================
# Exemplo para gerar de uma normal padrao pelo metodo
# da rejeicao utilizando proposta U(-10,10) e Cauchy
#====================================================
set.seed(12345)
n      <- 100000 # Tamanho da amostra

#====================================================
# Gerando de uma proposta U(-10,10)
#====================================================

# O valor que maxima a aceitacao para U(-10,10) e'
C  <- 20/sqrt(2*pi)
x  <- rep(NA,n)
k  <- 0
v  <- 0
while(k<=n){
	v <- v+1
	w  <- runif(1,-10,10)
	prob <- dnorm(w)/( C*dunif(w,-10,10) )
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
xseq <- seq(-4,4,length=1000)
yseq <- dnorm(xseq)
lines(xseq,yseq,col=2,lwd=3)

#====================================================
# Gerando de uma proposta Cauchy

# O valor que maxima a aceitacao para Cauchy e'
D  <- dnorm(1)/dt(1,1)
D
z  <- rep(NA,n)
k  <- 0
v  <- 0
while(k<=n){
	v  <- v+1
	w  <- rt(1,1)
	prob <- dnorm(w)/( D*dt(w,1) )
#	if( rbinom(1,1,prob) ){
	if( runif(1) < prob ){
		k    <- k+1
		z[k] <- w
	}
}

# taxa de aceitacao empirica
 n / v

x11()
hist(z,nclass=50,prob=T,main="",cex.axis=2,cex.lab=2,col="darkgreen")
xseq <- seq(-4,4,length=1000)
yseq <- dnorm(xseq)
lines(xseq,yseq,col=2,lwd=3)

#====================================================
# Fim
#====================================================

