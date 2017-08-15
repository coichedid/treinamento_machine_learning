# rm(list=ls())
#====================================================
# Exemplo para gerar de uma mistura discreta de 
# duas normais 
#====================================================
set.seed(12345)
n      <- 100000 # Tamanho da amostra
omega  <- 0.3
mu1    <- 10
sigma1 <- 1
mu2    <- 15
sigma2 <- 1.5
y      <- rbinom(n,1,omega)
mu     <- y*mu1    + (1-y)*mu2
sigma  <- y*sigma1 + (1-y)*sigma2
x      <- rnorm(n,mu,sigma)  

x11()
hist(x,nclass=50,prob=T,main="",cex.axis=2,cex.lab=2,col="darkgreen")
xseq <- seq(5,22,length=1000)
yseq <- omega*dnorm(xseq,mu1,sigma1)+(1-omega)*dnorm(xseq,mu2,sigma2)
lines(xseq,yseq,col=2,lwd=3)

#====================================================
# Fim
#====================================================
