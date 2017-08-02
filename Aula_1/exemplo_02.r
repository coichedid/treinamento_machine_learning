# Note que o R entende variaveis por colunas e 
# as amostras por linha. Entao e' necessario
# transpor a matriz de dados
p       <- 3                      # numero de variaveis
n       <- 10000                  # tamanho da amostra
X       <- matrix(rnorm(p*n),p,n) # definindo X
#pdf(file="dispersao_pairs.pdf")
#par(mfrow=c(1,1),lwd=2.0,cex.lab=1.5,cex.axis=1.5,
#    lab=c(10,5,5),mar=c(0,1,0,2.5),xpd=T,cex.main=2.0)
pairs(t(X),pch=15)
#dev.off()

apply(X,1,"mean")  # vetor (linhas) de medias
var(t(X))          # matriz de covariancias
cor(t(X))          # matriz de correlacoes

