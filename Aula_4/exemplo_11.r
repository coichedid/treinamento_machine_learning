# rm(list=ls())
#====================================================
# Exemplo para gerar da exponencial utilizando
# uniforme (0,1) e a transformacao inversa
#====================================================
# Para uma exponencial com parametro 1
set.seed(12345)
n  <- 10000 # Tamanho da amostra
x  <- -log(runif(n))
x11()
hist(x,nclass=50,prob=T,main="",cex.axis=2,cex.lab=2,col="darkgreen")
xseq <- seq(0.001,10,length=1000)
yseq <- dexp(xseq,1)
lines(xseq,yseq,col=2,lwd=3)
mean(x)

# Para uma exponencial com parametro lambda = 4
lambda <- 4
z      <- -log(runif(n))/lambda
x11()
hist(z,nclass=50,prob=T,main="",cex.axis=2,cex.lab=2,col="darkgreen")
zseq <- seq(0.001,10,length=1000)
wseq <- dexp(zseq,lambda)
lines(zseq,wseq,col=2,lwd=3)
mean(z)

#====================================================
# Fim
#====================================================
