# rm(list=ls())
#====================================================
# Exemplo para gerar da uniforme discreta 
# entre 1 e 10
#====================================================
set.seed(12345)
n  <- 10000 # Tamanho da amostra
I  <- seq(0,1,0.1)
x  <- rep(0,n)
for(i in 1:n){
	u <- runif(1)
	for (j in 1:10){
		if((u>I[j])&&(u<=I[j+1])) x[i] <- j 
	}
}
x11()
barplot(table(x)/n,ylim=c(0,0.15),cex.axis=2,cex.lab=2,col="darkgreen")

#====================================================
# Fim
#====================================================
