#===========================================================
# Exemplo
#===========================================================
n     <- 100000   # tamanho da amostra
p     <- 3        # dimensao

#===========================================================
# estrutura de covariancia (correlacao)
SIGMA <- matrix(c(1,0.9,0.8,0.9,1,0.7,0.8,0.7,1),p,p,T)
SIGMA

#===========================================================
# Gerando de normais independentes
#===========================================================
z     <- matrix(rnorm(p*n),n,p)

#===========================================================
# Grafico 1: avaliando a normalidade nas marginais
#===========================================================
x11()
par(mfrow=c(3,3))
hist(z[,1],prob=T,nclass=50,main="",xlab="x",ylab="Densidade")
boxplot(z[,1],ylab="x")
qqnorm(z[,1],xlab="Percentis teóricos",
       ylab="Percentis amostrais")
qqline(z[,1],col=4,lwd=3)
hist(z[,2],prob=T,nclass=50,main="",xlab="y",ylab="Densidade")
boxplot(z[,2],ylab="x")
qqnorm(z[,2],xlab="Percentis teóricos",
       ylab="Percentis amostrais")
qqline(z[,2],col=4,lwd=3)
hist(z[,3],prob=T,nclass=50,main="",xlab="y",ylab="Densidade")
boxplot(z[,3],ylab="x")
qqnorm(z[,3],xlab="Percentis teóricos",
       ylab="Percentis amostrais")
qqline(z[,3],col=4,lwd=3)

#===========================================================
# Grafico 2: avaliando a normalidade na estrutura de 
# dependencia (circulos porque sao normais independentes)
#===========================================================
x11()
pairs(z,pch=15)

#===========================================================
# Gerando da normal multivariada
# Primeiro metodo: decomposicao do valor singular (SVD) e 
# normais independentes
#===========================================================
S     <- svd(SIGMA)           # decomposicao SVD de SIGMA
V     <- S$u                  # matriz de autovetores coluna
D     <- diag(S$d)            # matriz de autovalores D
Dhalf <- diag(sqrt(S$d))      # D^{1/2}
ASVD  <- V%*%Dhalf            # construcao da matriz A
x     <- z%*%t(ASVD)          # gerando valores

#===========================================================
# Comparando as estimativas e valor verdadeiro
#===========================================================
cov(x)
cor(x)
SIGMA

#===========================================================
# Grafico 3: avaliando a normalidade nas marginais
#===========================================================
x11()
par(mfrow=c(3,3))
hist(x[,1],prob=T,nclass=50,main="",xlab="x",ylab="Densidade")
boxplot(x[,1],ylab="x")
qqnorm(x[,1],xlab="Percentis teóricos",
       ylab="Percentis amostrais")
qqline(x[,1],col=4,lwd=3)
hist(x[,2],prob=T,nclass=50,main="",xlab="y",ylab="Densidade")
boxplot(x[,2],ylab="x")
qqnorm(x[,2],xlab="Percentis teóricos",
       ylab="Percentis amostrais")
qqline(x[,2],col=4,lwd=3)
hist(x[,3],prob=T,nclass=50,main="",xlab="y",ylab="Densidade")
boxplot(x[,3],ylab="x")
qqnorm(x[,3],xlab="Percentis teóricos",
       ylab="Percentis amostrais")
qqline(x[,3],col=4,lwd=3)

#===========================================================
# Grafico 4: avaliando a normalidade na estrutura de 
# dependencia (circulos porque sao normais independentes)
#===========================================================
x11()
pairs(x,pch=15)

#===========================================================
# Gerando da normal multivariada
# Segundo metodo: decomposicao de Cholesky e 
# normais independentes
#===========================================================
ACHOL <- chol(SIGMA)
y     <- z%*%ACHOL

#===========================================================
# Comparando as estimativas e valor verdadeiro
#===========================================================
cov(y)
cor(y)
SIGMA

#===========================================================
# Grafico 5: avaliando a normalidade nas marginais
#===========================================================
x11()
par(mfrow=c(3,3))
hist(y[,1],prob=T,nclass=50,main="",xlab="x",ylab="Densidade")
boxplot(y[,1],ylab="x")
qqnorm(y[,1],xlab="Percentis teóricos",
       ylab="Percentis amostrais")
qqline(y[,1],col=4,lwd=3)
hist(y[,2],prob=T,nclass=50,main="",xlab="y",ylab="Densidade")
boxplot(y[,2],ylab="x")
qqnorm(y[,2],xlab="Percentis teóricos",
       ylab="Percentis amostrais")
qqline(y[,2],col=4,lwd=3)
hist(y[,3],prob=T,nclass=50,main="",xlab="y",ylab="Densidade")
boxplot(y[,3],ylab="x")
qqnorm(y[,3],xlab="Percentis teóricos",
       ylab="Percentis amostrais")
qqline(y[,3],col=4,lwd=3)

#===========================================================
# Grafico 6: avaliando a normalidade na estrutura de 
# dependencia (circulos porque sao normais independentes)
#===========================================================
x11()
pairs(y,pch=15)
SIGMA

#===========================================================
# Note que x e y sao valores diferentes
#===========================================================
apply((x-y),2,sum)

#===========================================================
# Agora, utilizando a funcao 'rmvnorm' do pacote 'mvtnorm'
# Repetindo as mesmas analises anteriores
#===========================================================
library(mvtnorm)
w     <- rmvnorm(n,mean=rep(0,3),sigma=SIGMA)

#===========================================================
# Comparando as estimativas e valor verdadeiro
#===========================================================
cov(w)
cor(w)
SIGMA

#===========================================================
# Grafico 7: avaliando a normalidade nas marginais
#===========================================================
x11()
par(mfrow=c(3,3))
hist(w[,1],prob=T,nclass=50,main="",xlab="x",ylab="Densidade")
boxplot(w[,1],ylab="x")
qqnorm(w[,1],xlab="Percentis teóricos",
       ylab="Percentis amostrais")
qqline(w[,1],col=4,lwd=3)
hist(w[,2],prob=T,nclass=50,main="",xlab="y",ylab="Densidade")
boxplot(w[,2],ylab="x")
qqnorm(w[,2],xlab="Percentis teóricos",
       ylab="Percentis amostrais")
qqline(w[,2],col=4,lwd=3)
hist(w[,3],prob=T,nclass=50,main="",xlab="y",ylab="Densidade")
boxplot(w[,3],ylab="x")
qqnorm(w[,3],xlab="Percentis teóricos",
       ylab="Percentis amostrais")
qqline(w[,3],col=4,lwd=3)

#===========================================================
# Grafico 8: avaliando a normalidade na estrutura de 
# dependencia (circulos porque sao normais independentes)
#===========================================================
x11()
pairs(w,pch=15)
SIGMA

#===========================================================
# Fim
#===========================================================
