#===========================================================
# Exemplo
#===========================================================
u   <- seq(0,10)        # Urnas enumeradas 
pu  <- rep(1/11,11)     # Probabilidade da urna u ser 
                        # selecionada
nb  <- seq(0,10)        # Numeros de bolas pretas selecionadas
fb  <- u/10             # Probabilidade de selecionar uma bola 
                        # preta na urna u    

#===========================================================
# Salvando as probabilidades de selecionar nb bolas pretas
# (com reposição) da urna u
#===========================================================
pnb <- matrix(NA,11,11)
colnames(pnb) <- c("Urna 0","Urna 1","Urna 2","Urna 3",
"Urna 4","Urna 5","Urna 6","Urna 7","Urna 8","Urna 9",
"Urna 10")
rownames(pnb) <- seq(0,10)
for(i in 1:11)
	pnb[,i] <- dbinom(nb,10,fb[i])
pnb 

apply(pnb,2,"sum")

#===========================================================
# Distribuicao conjunta de u e nb
#===========================================================
punb  <- pnb/11
apply(punb,1,"sum")
apply(punb,2,"sum")
sum(punb)

#===========================================================
# Distribuicao condicional de u dado nb=3
#===========================================================
punb3 <- pnb["3",]*(1/11)   # Sem normalizar
sum(punb3)
punb3  <- punb3/sum(punb3)
plot(0:10,punb3,type="h",lwd=2,col=4,xlab="Urna u",
   ylab=expression(paste(paste("Pr(u|",n[B],sep=""),",N)")))

# Note que nao e' necessario calcular a verossimilhanca
# marginal. Basta normalizar as probabilidades a posteriori.

#===========================================================
# Preditiva
# Probabilidade da bola N+1 ser preta dado que sairam
# nb=3 bolas pretas nas N primeiras retiradas (com reposicao)
#===========================================================
pBN1U3 <- u/10  # probabilidade da bola ser preta dado 
                # nb=3 e a urna u (nb=3 nao influencia)
                # porque a selecao e' com reposicao
pBN1U3

pBN1   <- sum(pBN1U3*punb3) # Preditiva (sair bola preta)
                            # dado que sairam 3 bolas pretas

pBN1

# Note que esta probabilidade e' diferente de tomar u=3
# por ter prob = 0,29 e calcular como u/10=3/10=0,3.

#===========================================================
# Fim
#===========================================================
