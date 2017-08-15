# rm(list=ls())
#====================================================
# Exemplo para gerar da Bernoulli a partir de U(0,1)
#====================================================
set.seed(12345)
p  <- 0.9  # Probabilidade de X=1
n  <- 1000 # Tamanho da amostra

# Primeira maneira 
x  <- rep(0,n)
for(i in 1:n){
  u <- runif(1)
  if(u <= 0.9) x[i] <- 1
}
x11()
barplot(table(x)/n,ylim=c(0,1),cex.axis=2,cex.lab=2,col="darkgreen")
mean(x)

# Segunda maneira
# Tudo em bloco!
w  <- as.integer( runif(n) <= p )
x11()
barplot(table(w)/n,ylim=c(0,1),cex.axis=2,cex.lab=2,col="darkblue")
mean(w)

#====================================================
# Fim
#====================================================