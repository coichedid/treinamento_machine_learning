# rm(list=ls())
#====================================================
# Exemplo para gerar da normal padrao truncada em
# (0,1) utilizando o amostrador da fatia
# (slice sampling)
#====================================================
# Grafico da N(0,1). 
# Adicionaremos a este os valores gerados do par (x,y) 
dnormtrunc <- function(x,mu,sigma,a,b){
  dnorm(x,mu,sigma)/(pnorm(b,mu,sigma)-pnorm(a,mu,sigma))
}
xseq   <- seq(0,1,length=1001)
zseq   <- dnormtrunc(xseq,0,1,0,1)

x11()
plot(xseq,zseq,type="l",lwd=3,col=4,xlab=expression(x),
     ylab=expression(f(x)),ylim=c(0,1.2))
lines(rep(1,10),seq(0,dnormtrunc(1,0,1,0,1),l=10),lwd=3,col=4)
lines(rep(0,10),seq(0,dnormtrunc(0,0,1,0,1),l=10),lwd=3,col=4)

#====================================================
# Amostrador da fatia
set.seed(12345)
n    <- 100000       # tamanho da amostra
x0   <- runif(1)     # valor inicial
x    <- rep(NA,n+1)
x[1] <- x0
y    <- rep(NA,n)
aux  <- 0.5*log(2*pi) + log(pnorm(1)-pnorm(0))
for(i in 1:n){
  y[i]   <-  runif(1)*dnormtrunc(x[i],0,1,0,1)
  ub     <-  min(sqrt(-2*(log(y[i])+aux)),1)
  x[i+1] <-  runif(1,0,ub)
  points(x[i],y[i],pch=16)
}

# Definicoes para analise grafica
x   <- x[1:n]
xx  <- acf(x,lag.max=100,plot=F)$lag
yy  <- acf(x,lag.max=100,plot=F)$acf
xx  <- xx[2:length(xx)]
yy  <- yy[2:length(yy)]

x11()
par(mfrow=c(2,2))
plot(xseq,zseq,type="l",xlab=expression(x),
     ylab=expression(f(x)),ylim=c(0,1.2))
lines(xseq,zseq,type="l",col=1,lwd=3)
points(x,y,pch=16,col=4)
hist(x,main="",ylab=expression(f(x)),probability=TRUE,
     nclass=30,xlim=c(0,1),col=4,xlab=expression(x))
lines(xseq,zseq,type="l",col=1,lwd=3)
ts.plot(x,col=4,xlab="Iteração",ylab=expression(x[i]))
plot(xx,yy,type="h",col=1,ylim=c(-max(abs(yy))*1.01,
                                 max(abs(yy))*1.01),xlab="Defasagem",ylab="ACF")
lines(xx,yy,type="h",col=4)
lines(xx,rep(-1.96/sqrt(n),length(xx)),type="l",
      col=2,lty=2,lwd=2)
lines(xx,rep( 1.96/sqrt(n),length(xx)),type="l",
      col=2,lty=2,lwd=2)

#====================================================
# Fim
#====================================================