# rm(list=ls())
#====================================================
# Exemplo: analise bayesiana de dados Binomial(m,pix)
# com priori beta(a,n)
# Ver exemplo_08.r
#====================================================
set.seed(12345)

#====================================================
# Primeiro, vamos gerar dados artificiais da Binomial
# Uma amostra aleatoria simples de Bin(m;pix)
#====================================================
m     <- 10   # Numero de ensaios de Bernoulli
pix   <- 0.8  # Probabilidade de sucesso

#====================================================
# Agora, vamos calcular todas as probabilidades 
# Serve para efeito de comparacoes
#====================================================
xseq  <- 0:m
probx <- dbinom(xseq,m,pix)
x11()
plot(xseq,probx,type="h",lwd=3,col=4,
     xlab=expression(x),ylab=expression(f(x)))

#====================================================
# Gerando uma amostra aleatoria de Bin(m;pix)
#====================================================
n    <- 15     # Tamanho da amostra
x    <- rbinom(n,m,pix)

#====================================================
# Funcao de verossimilhanca de pix
# pix deve ser escalar e x vetor
#====================================================
verox <- function(pix,x){
  out <- prod(dbinom(x,m,pix))
  return(out)
}

K     <- 999 # tamanho da sequencia
xpix  <- seq(0.001,0.999,length=K)
ypix  <- rep(NA,K)
for(i in 1:K) ypix[i] <- verox(xpix[i],x)
c     <- sum(ypix*0.001) # constante 

x11()
plot(xpix,ypix/c,type="l",lwd=3,col=4,
     xlab=expression(pi),ylab=expression(L(pi)))
points(rep(mean(x)/m,2),c(0,max(ypix)/c),type="h",
       col=2,lwd=2,lty=2)
legend(0,10,legend=c("Verossimilhança","EMV"),bty="o",
       col=c(4,2),lwd=rep(2,2),lty=c(1,2))

#====================================================
# A estimativa de maxima verossimilhanca 
#====================================================
pixmv <- mean(x)/m
pixmv

#====================================================
# Distribuicao a prior: Triangular( a , b, c)
# com a < b < c,  a=0  e c=1.
#
# f(pix) = 2*pix/b*I[0,b) + 2*(1-pix)/(1-b)*I[b,1]
#
#====================================================
b     <- 0.7
zpix  <- c(2*(xpix[xpix<b]/b),2*(1-xpix[xpix>=b])/(1-b))

x11()
plot(xpix,ypix/c,type="l",lwd=3,col=4,
     xlab=expression(pi),ylab=expression(L(pi)))
points(rep(mean(x)/m,2),c(0,max(ypix)/c),type="h",
       col=2,lwd=2,lty=2)
lines(xpix,zpix,col=3,lwd=2)
legend(0,10,legend=c("Verossimilhança","EMV","Priori"),
       bty="o",col=c(4,2,3),lwd=rep(2,3),lty=c(1,2,1))

#====================================================
# Dist. a posteriori: verossimilhanca binomial
# priri triangular
#====================================================
wpix  <- ypix*zpix
d     <- sum(wpix*0.001) # constante 

x11()
plot(xpix,ypix/c,type="l",lwd=3,col=4,
     xlab=expression(pi),ylab=expression(L(pi)))
points(rep(mean(x)/m,2),c(0,max(ypix)/c),type="h",
       col=2,lwd=2,lty=1)
lines(xpix,zpix,col=3,lwd=2)
lines(xpix,wpix/d,col=5,lwd=2)
legend(0,10,legend=c("Verossimilhança","EMV","Priori",
                     "Posteriori"),bty="o",col=c(4,2,3,5),
       lwd=rep(2,4),lty=c(1,2,1,1))

#====================================================
# Gerando de uma proposta Beta(n*xbar+1; n*(m-xbar)+1)
#
# Essa proposta considera praticamente a forma da 
# verossimilhanca. Isto simplifica os calculos.
# A aproximacao sera'a boa se a verossimilhanca for
# mais informativa do que a priori.
# 
#====================================================
xbar   <- mean(x)
apost  <- n*xbar + 1     # parametro da proposta
bpost  <- n*(m-xbar) + 1 # parametro da proposta
N      <- 50000          # Tamanho da amostra
M      <- 10000          # Reamostragem

#====================================================
# Gerando da proposta
#====================================================
piprop <- rbeta(N,apost,bpost)

#====================================================
# Note que calcularemos os pesos abaixo sem a 
# necessidade de constantes. Neste caso so' a priori.
#====================================================
library("triangle")
pesos  <- dtriangle(piprop,0,1,b)
prob   <- pesos/sum(pesos)
sum(prob)
z      <- sample(piprop,M,replace=T,prob=prob)

x11()
hist(z,lwd=3,main="",prob=T,xlim=c(0,1),nclass=30,
     xlab=expression(pi),ylab=expression(L(pi)))
lines(xpix,ypix/c,lwd=3,col=4)
points(rep(mean(x)/m,2),c(0,max(ypix)/c),type="h",
       col=2,lwd=2,lty=1)
lines(xpix,zpix,col=3,lwd=2)
lines(xpix,wpix/d,col=5,lwd=2)
legend(0,10,legend=c("Verossimilhança","EMV","Priori",
                     "Posteriori"),bty="o",col=c(4,2,3,5),
       lwd=rep(2,4),lty=c(1,2,1,1))

#====================================================
# Resumo da distribuicao a posteriori
# Estimativas pontuais e intervalar
#====================================================
mean(z)                       # media a posteriori
median(z)                     # mediana a posteriori
var(z)
sd(z)

# intervalo de credibilidade de 90%
quantile(z,probs=c(0.05,0.95)) 

# intervalo de credibilidade de 95%
quantile(z,probs=c(0.025,0.975)) 

#====================================================
# Fim
#====================================================