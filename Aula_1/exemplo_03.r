library(mvtnorm)
nx  <- 100
ny  <- 100
x   <- seq(-4,4,length=nx)
y   <- seq(-4,4,length=ny)
z   <- matrix(NA,nx,ny)
mu  <- c(0,0)
S   <- matrix(c(1, .7, .7, 1),2,2)
for(i in 1:nx)
    for(j in 1:ny)
        z[i,j] <- dmvnorm(c(x[i],y[j]), mean=mu,sigma=S)
# Grafico 1
x11()
persp(x,y,z, phi = 45, theta = 30,col=3)
# Grafico 2
x11()
contour(x,y,z,col=2,lwd=2)
#-----------------------------------
w <- rmvnorm(100000,mean=mu,sigma=S)
#Grafico 3
x11()
par(mfrow=c(2,2))
plot(w,pch=".",main="",xlab="x",ylab="y")
hist(w[,2],prob=T,nclass=50,main="",xlab="y")
lines(y,dnorm(y),lwd=2,col=2)
hist(w[,1],prob=T,nclass=50,main="",xlab="x")
lines(x,dnorm(x),lwd=2,col=2)
