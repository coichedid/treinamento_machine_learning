#===========================================================
# Exemplo
#===========================================================
# A f.d.p. de uma exponencial 
#===========================================================

lambda1 <- 2   # valor caracteristico (parametro)
lambda2 <- 5   # valor caracteristico (parametro)
lambda3 <- 10  # valor caracteristico (parametro)
x       <- seq(-1,30,length=1000) # grade de valores
fx1     <- dexp(x,rate=1/lambda1) # f.d.p.
fx2     <- dexp(x,rate=1/lambda2) # f.d.p.
fx3     <- dexp(x,rate=1/lambda3) # f.d.p.

x11()
plot(x,fx1,type="l",lwd=2,col=1,xlab=expression(x),
     ylab=expression(f(x))) # densidade p/ lambda=2
lines(x,fx2,col=2,lwd=2)    # densidade p/ lambda=5
lines(x,fx3,col=4,lwd=2)    # densidade p/ lambda=10
legend(20,0.4,              # legenda do grafico
       legend=c(expression(paste(lambda,"=1",sep="")),
                expression(paste(lambda,"=5",sep="")),
                expression(paste(lambda,"=10",sep=""))),
       lty=rep(1,3),lwd=rep(2,3),col=c(1,2,4),bty="n")

#===========================================================
# Geracao de numeros aleatorios
#===========================================================
N  <- 1000                    # tamanho da amostra
y1 <- rexp(N,rate=1/lambda1)  # amostra gerada de lambda=2
y2 <- rexp(N,rate=1/lambda2)  # amostra gerada de lambda=5
y3 <- rexp(N,rate=1/lambda3)  # amostra gerada de lambda=10

x11()
par(mfrow=c(1,3))
hist(y1,nclass=20,prob=T,main="",
     xlab=expression(x),ylab=expression(f(x)))
lines(x,fx1,col=1,lwd=2)       # densidade p/ lambda=5
hist(y2,nclass=20,prob=T,main="",
     xlab=expression(x),ylab=expression(f(x)))
lines(x,fx2,col=2,lwd=2)       # densidade p/ lambda=5
hist(y3,nclass=20,prob=T,main="",
     xlab=expression(x),ylab=expression(f(x)))
x   <- seq(-1,600,length=1000) # grade de valores
fx3 <- dexp(x,rate=1/lambda3)  # f.d.p.
lines(x,fx3,col=4,lwd=2)       # densidade p/ lambda=10

#===========================================================
# Como a exponencial tem media lambda, entao parece
# razoavel estimar este valor com a media amostral 
# (estimacao pelo metodo dos momentos)
#===========================================================
lambda1.hat <- mean(y1)
lambda2.hat <- mean(y2)
lambda3.hat <- mean(y3)

lambda1.hat
lambda2.hat
lambda3.hat

#===========================================================
# A funcao de verossimilhanca 
#===========================================================

lambda   <- seq(0.001,100,length=1000)
flambda1 <- dexp(3,1/lambda)   
flambda2 <- dexp(5,1/lambda)   
flambda3 <- dexp(12,1/lambda)   

x11()
plot(lambda,flambda1,type="l",lwd=2,col=1,xlab=expression(x),
     ylab=expression(L(lambda)))   # verossimilhanca x=3
lines(rep(3,2),c(0,max(flambda1)),col=1,lwd=2,lty=2)
lines(lambda,flambda2,col=2,lwd=2) # verossimilhanca x=5
lines(rep(5,2),c(0,max(flambda2)),col=2,lwd=2,lty=2)
lines(lambda,flambda3,col=4,lwd=2) # verossimilhanca x=12
lines(rep(12,2),c(0,max(flambda3)),col=4,lwd=2,lty=2)
legend(40,0.1,              # legenda do grafico
       legend=c(expression(paste(x,"=3",sep="")),
                expression(paste(x,"=5",sep="")),
                expression(paste(x,"=12",sep=""))),
       lty=rep(1,3),lwd=rep(2,3),col=c(1,2,4),bty="n")

#===========================================================
# A f.d.p. da exponencial truncada no intervalo (a,b)
#===========================================================
dexptrunc <- function(x,rate=1,a=0,b=Inf){
	n   <- length(x)
	onx <- as.numeric(x<a | x>b)
	aux <- pexp(b,rate)-pexp(a,rate)
	out <- onx*rep(0,n)+(1-onx)*dexp(x,rate)/aux
	return(out)
}

lambda1 <- 2   # valor caracteristico (parametro)
lambda2 <- 5   # valor caracteristico (parametro)
lambda3 <- 10  # valor caracteristico (parametro)
xtrc    <- seq(0,22,length=1000) # grade de valores
fx1trc  <- dexptrunc(xtrc,rate=1/lambda1,1,20) # f.d.p.
fx2trc  <- dexptrunc(xtrc,rate=1/lambda2,1,20) # f.d.p.
fx3trc  <- dexptrunc(xtrc,rate=1/lambda3,1,20) # f.d.p.

x11()
plot(xtrc,fx1trc,type="l",lwd=2,col=1,xlab=expression(x),
     ylab=expression(f(x))) # densidade p/ lambda=2
lines(xtrc,fx2trc,col=2,lwd=2) # densidade p/ lambda=5
lines(xtrc,fx3trc,col=4,lwd=2) # densidade p/ lambda=10
legend(10,0.4,              # legenda do grafico
       legend=c(expression(paste(lambda,"=1",sep="")),
                expression(paste(lambda,"=5",sep="")),
                expression(paste(lambda,"=10",sep=""))),
       lty=rep(1,3),lwd=rep(2,3),col=c(1,2,4),bty="n")


#===========================================================
# A funcao de verossimilhanca da exponencial truncada
#===========================================================

lambdatrc   <- seq(0.001,50,length=1000)
flambda1trc <- dexptrunc(3,1/lambdatrc,1,20)   
flambda2trc <- dexptrunc(5,1/lambdatrc,1,20)   
flambda3trc <- dexptrunc(12,1/lambdatrc,1,20)   

x11()
plot(lambdatrc,flambda1trc,type="l",lwd=2,col=1,
    xlab=expression(x),ylab=expression(L(lambda))) # veros x=3
lines(rep(3,2),c(0,max(flambda1trc)),col=1,lwd=2,lty=2)
lines(lambdatrc,flambda2trc,col=2,lwd=2) # verossimilhanca x=5
lines(rep(5,2),c(0,max(flambda2trc)),col=2,lwd=2,lty=2)
lines(lambdatrc,flambda3trc,col=4,lwd=2) # verossimilhanca x=12
lines(rep(12,2),c(0,max(flambda3trc)),col=4,lwd=2,lty=2)
legend(40,0.1,              # legenda do grafico
       legend=c(expression(paste(x,"=3",sep="")),
                expression(paste(x,"=5",sep="")),
                expression(paste(x,"=12",sep=""))),
       lty=rep(1,3),lwd=rep(2,3),col=c(1,2,4),bty="n")

#===========================================================
# A funcao de verossimilhanca da exponencial truncada
#===========================================================

n           <- 6
xsample     <- c(1.5,2,3,4,5,12)
ngrid       <- 1000
lambdatrc   <- seq(0.001,100,length=ngrid)
flambdatrc  <- rep(NA,ngrid)
for(i in 1:ngrid){
	aux <- dexptrunc(xsample[1],1/lambdatrc[i],1,20)
	for(j in 2:n) 
		aux <- aux*dexptrunc(xsample[j],1/lambdatrc[i],1,20)
	flambdatrc[i] <- aux
}

x11()
plot(lambdatrc,flambda1trc,type="l",lwd=2,col=1,
    xlab=expression(x),ylab=expression(L(lambda))) 


#===========================================================
# Fim
#===========================================================


