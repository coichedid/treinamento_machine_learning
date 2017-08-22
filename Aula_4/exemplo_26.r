# rm(list=ls())
#====================================================
# Exemplo de aproximacao assintotica pela Normal
#
#====================================================
# Amostra n=1 e y=3.
#====================================================
y         <- 3
alpha     <- 3             # hiperparametros
beta      <- 3             # hiperparametros
x         <- seq(-2,6,0.01) 
lambda1   <- dgamma(x,alpha+y,beta+1)
media1    <- (alpha+y-1)/(beta+1)
var1      <- media1/(beta+1)
lambda2   <- dnorm(x,media1,sqrt(var1))

#====================================================
# Grafico para comparacao
#====================================================

x11()
par(mfrow=c(1,1),lwd=2.0,cex.lab=1.5,cex.axis=1.5,lab=c(10,5,5),
    mar=c(5,5,2,2.5),xpd=T,cex.main=2.0)
plot(x,lambda1,type="l",lwd=2,col=1,xlab=expression(lambda),
     ylab=expression(paste("f(",lambda,"|y)",sep=" ")))
lines(x,lambda2,lwd=2,col=2,lty=2)
legend("topright",legend=c("Verdadeira","Aproximada"),
       col=c(1,2),lty=c(1,2),lwd=c(2,2))

#====================================================
# Lognormal
#====================================================

media2    <- log((alpha+y)/(beta+1))
var2      <- 1/(alpha+y)
lambda3   <- dlnorm(x,media2,sqrt(var2))

#====================================================
# Grafico para comparacao
#====================================================

x11()
par(mfrow=c(1,1),lwd=2.0,cex.lab=1.5,cex.axis=1.5,lab=c(10,5,5),
    mar=c(5,5,2,2.5),xpd=T,cex.main=2.0)
plot(x,lambda1,type="l",lwd=2,col=1,xlab=expression(lambda),
     ylab=expression(paste("f(",lambda,"|y)",sep=" ")))
lines(x,lambda2,lwd=2,col=2,lty=2)
lines(x,lambda3,lwd=2,col=4,lty=2)
legend("topright",legend=c("Verdadeira","Aproximada Normal",
                           "Aproximada Lognormal"),col=c(1,2,4),lty=c(1,2,2),lwd=c(2,2,2))

#====================================================
# Fim
#====================================================

