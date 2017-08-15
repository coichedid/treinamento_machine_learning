# rm(list=ls())
#====================================================
# Exemplo para gerar de uma mistura discreta de 
# duas normais 
#====================================================
set.seed(12345)
n      <- 100000 # Tamanho da amostra
mu     <- 5
sigma  <- 2
nu     <- 10
lambda <- rgamma(n,0.5*nu,0.5*nu)
x      <- rnorm(n,rep(mu,n),sigma/sqrt(lambda))
  
x11()
hist(x,nclass=50,prob=T,main="",cex.axis=2,cex.lab=2,col="darkgreen")
xseq <- seq(-10,22,length=1000)
yseq <- dt((xseq-mu)/sigma,nu)/sigma
lines(xseq,yseq,col=2,lwd=3)

x11()
plot(x,lambda,pch="*",ylab=expression(lambda))
# Valores pequenos de lambda (grandes para 1/lambda)
# tendem a levar a valores grandes em X

#====================================================
# Fim
#====================================================
