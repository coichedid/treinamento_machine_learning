# rm(list=ls())
#====================================================
# Exemplo: analise bayesiana de dados Binomial(m,pix)
# com priori beta(a,n)
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
# EMV = Estimador de Verossimilhanca
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
mean(x)/m

#====================================================
# Distribuicao a prior: Beta( a , b)
#====================================================
a     <-  1.5
b     <-  1.5
zpix  <- dbeta(xpix,a,b)

x11()
plot(xpix,ypix/c,type="l",lwd=3,col=4,
     xlab=expression(pi),ylab=expression(L(pi)))
points(rep(mean(x)/m,2),c(0,max(ypix)/c),type="h",
     col=2,lwd=2,lty=2)
lines(xpix,zpix,col=3,lwd=2)
legend(0,10,legend=c("Verossimilhança","EMV","Priori"),
bty="o",col=c(4,2,3),lwd=rep(2,3),lty=c(1,2,1))

#====================================================
# Dist. a posteriori: Beta( n*xbar+a; n*(m-xbar)+b )
# = Beta( apost ; bpost)
#====================================================
xbar  <- mean(x)
apost <- n*xbar + a
bpost <- n*(m-xbar) + b
wpix  <- dbeta(xpix,apost,bpost)

x11()
plot(xpix,ypix/c,type="l",lwd=3,col=4,
     xlab=expression(pi),ylab=expression(L(pi)))
points(rep(mean(x)/m,2),c(0,max(ypix)/c),type="h",
     col=2,lwd=2,lty=1)
lines(xpix,zpix,col=3,lwd=2)
lines(xpix,wpix,col=5,lwd=2)
legend(0,10,legend=c("Verossimilhança","EMV","Priori",
"Posteriori"),bty="o",col=c(4,2,3,5),
lwd=rep(2,4),lty=c(1,2,1,1))

#====================================================
# Resumo da distribuicao a posteriori
# Estimativas pontuais e intervalar
#====================================================
apost / (apost + bpost)       # media a posteriori
(apost-1)/(apost + bpost - 2) # moda a posteriori
qbeta(0.5,apost,bpost)        # mediana a posteriori

# intervalo de credibilidade de 90%
qbeta(c(0.05,0.95),apost,bpost) 

# intervalo de credibilidade de 95%
qbeta(c(0.025,0.975),apost,bpost) 

#====================================================
# Fim
#====================================================
