# rm(list=ls())
#====================================================
# Exemplo 1 para gerar de uma mistura discreta de 
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
# Exemplo 2 para gerar de uma mistura discreta de 
# duas normais pelo metodo da amostragem ponderada 
#====================================================
# Proposta U(0,20)
m      <- 50000  # reamostragem
xprop  <- runif(n,0,20)
pesos  <- 20*(     omega*dnorm(xprop,mu1,sigma1)
                   +(1-omega)*dnorm(xprop,mu2,sigma2)) 
prob   <- pesos/sum(pesos)	
sum(prob)
y      <- sample(xprop,m,replace=T,prob=prob)

x11()
hist(y,nclass=50,prob=T,main="",cex.axis=2,cex.lab=2,col="darkgreen")
xseq <- seq(5,22,length=1000)
yseq <- omega*dnorm(xseq,mu1,sigma1)+(1-omega)*dnorm(xseq,mu2,sigma2)
lines(xseq,yseq,col=2,lwd=3)

#====================================================
#
# PROBLEMAS de cobertura na cauda superior!
#
#====================================================

# probabilidade de X>20
1-(omega*pnorm(20,mu1,sigma1)+(1-omega)*pnorm(20,mu2,sigma2))

# probabilidade de X<0
omega*pnorm(0,mu1,sigma1)+(1-omega)*pnorm(0,mu2,sigma2)

#====================================================
# Exemplo 3 para gerar de uma mistura discreta de 
# duas normais pelo metodo da amostragem ponderada 
#====================================================
# Proposta N(13,5; 3^2)
mu     <-  omega*mu1+(1-omega)*mu2
mu
# valor esperado da variancia condicional
aux1   <- omega*(sigma1^2)+(1-omega)*(sigma2^2)
# variancia do valor esperado condicional
aux2   <- omega*(mu1-mu)^2+(1-omega)*(mu2-mu)^2
sig2   <- aux1+aux2          
sig2 # Vamos escolher um valor um pouco maior: 9

m      <- 50000  # reamostragem
xprop  <- rnorm(n,mu,3)
pesos  <- ( (     omega*dnorm(xprop,mu1,sigma1)
                  +(1-omega)*dnorm(xprop,mu2,sigma2))/
              dnorm(xprop,mu,3) )
prob   <- pesos/sum(pesos)	
sum(prob)
z      <- sample(xprop,m,replace=T,prob=prob)

x11()
hist(z,nclass=50,prob=T,main="",cex.axis=2,cex.lab=2,col="darkgreen")
xseq <- seq(5,22,length=1000)
yseq <- omega*dnorm(xseq,mu1,sigma1)+(1-omega)*dnorm(xseq,mu2,sigma2)
lines(xseq,yseq,col=2,lwd=3)

# Algum valor maior que 20?
any(z>20)

#====================================================
# Fim
#====================================================