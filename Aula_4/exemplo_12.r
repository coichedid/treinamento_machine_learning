# rm(list=ls())
#====================================================
# Exemplo para gerar da gama(kappa,beta) utilizando
# uniforme (0,1), transformacao inversa e de escala
#====================================================
# Para uma gama com kappa = 2 e beta = 4
set.seed(12345)
n      <- 10000 # Tamanho da amostra
kappa  <- 2
beta   <- 4
z      <- matrix(-log(runif(floor(kappa)*n))/beta,n,floor(kappa))
x      <- apply(z,1,"sum")

x11()
hist(x,nclass=30,prob=T,main="",cex.axis=2,cex.lab=2,col="darkgreen")
xseq <- seq(0.001,3,length=1000)
yseq <- dgamma(xseq,kappa,beta)
lines(xseq,yseq,col=2,lwd=3)

#====================================================
# Fim
#====================================================
