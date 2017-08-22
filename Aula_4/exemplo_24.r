# rm(list=ls())
#====================================================
# Exemplo para gerar da normal padrao utilizando o
# amostrador da fatia (slice sampling)
#====================================================
# Grafico da N(0,1). 
# Adicionaremos a este os valores gerados do par (x,y) 
x1   <- seq(-4,4,0.01)
y1   <- dnorm(x1,0,1)
x11()
plot(x1,y1,type="l",xlab=expression(x),
     ylab=expression(f(x)),col=4,lwd=3)
#====================================================
# Amostrador da fatia
set.seed(12345)
n    <- 100000 # tamanho da amostra
x0   <- 3      # valor inicial
x    <- rep(NA,n+1)
x[1] <- x0
y    <- rep(NA,n)
for(i in 1:n){
  y[i]   <-  runif(1)*dnorm(x[i])
  lb     <- -sqrt(-2*( log(y[i]) + 0.5*log(2*pi) ) )
  ub     <-  sqrt(-2*( log(y[i]) + 0.5*log(2*pi) ) )
  x[i+1] <-  runif(1,lb,ub)
  points(x[i],y[i],pch=16)
}	

#  Definicao para analise grafica
x   <- x[1:n]
xx  <- acf(x,lag.max=100,plot=F)$lag
yy  <- acf(x,lag.max=100,plot=F)$acf
xx  <- xx[2:length(xx)]
yy  <- yy[2:length(yy)]

x11()
par(mfrow=c(2,2))
plot(x1,y1,type="l",xlab=expression(x),ylab=expression(f(x)))
lines(x1,y1,type="l",col=1,lwd=3)
points(x,y,pch=16,col=4)
hist(x,main="",ylab=expression(f(x)),probability=TRUE,nclass=30,
     xlim=c(-4,4),col=4,xlab=expression(x))
lines(x1,y1,type="l",col=1,lwd=3)
ts.plot(x,col=4,xlab="Iteração",ylab=expression(x[i]))
plot(xx,yy,type="h",col=1,ylim=c(-max(abs(yy))*1.01,
                                 max(abs(yy))*1.01),xlab="Defasagem",ylab="ACF")
lines(xx,yy,type="h",col=4)
lines(xx,rep(-1.96/sqrt(n),length(xx)),type="l",col=2,lty=2,lwd=2)
lines(xx,rep( 1.96/sqrt(n),length(xx)),type="l",col=2,lty=2,lwd=2)

x11()
par(mfrow=c(1,2))
boxplot(x,pch=16,main="",col=4)
qqnorm(x,pch=16,main="",col=4)
qqline(x)

#====================================================
# Fim
#====================================================