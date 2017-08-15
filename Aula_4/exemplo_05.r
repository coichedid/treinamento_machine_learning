# rm(list=ls())
#====================================================
# Funcao para a solucao de sistemas lineares dado
# um sistema triangular inferior
#====================================================
sistema.triang <- function(L,b){
  n    <- length(b)
  x    <- 0
  x[1] <- b[1]/L[1,1]
  for(i in 2:n)
    x[i] <- (b[i]-sum(L[i,1:(i-1)]*x[1:(i-1)]))/L[i,i]
  return(x)
}
#====================================================
# Funcao para a decomposicao de Cholesky 
# Seja uma A positiva definida
# A = U' * U 
#====================================================
decomp.cholesky <- function(A){
  n <- dim(A)[1]
  U <- matrix(0,n,n)
  # para i=1
  U[1,1]   <- sqrt(A[1,1])
  U[1,2:n] <- A[1,2:n]
  if(U[1,1]<=0.0) # Matriz nao positiva definida!
    print("A decomposicao de Cholesky falhou!")
  for(i in 2:n){
    for(j in i:n){
      sum = A[i,j]
      for(k in 1:(i-1)){ 
        sum = sum - U[k,i]*U[k,j]
      }
      if(i==j){
        if(sum<=0.0) # A nao eh positiva definida!
          print("A decomposicao de Cholesky falhou!")
        U[i,i] <- sqrt(sum)
      } else {
        U[i,j] = sum/U[i,i]
      }
    }
  }
  return(U)
}
#====================================================
# Exemplo
aux  <- c(1.0,0.7,0.5,0.7,1.0,0.8,0.5,0.8,1.0)
A    <-  matrix(aux,3,3,byrow=T)
A
#====================================================
# Utilizando as funcoes dos exemplos anteriores
L     <- t(decomp.cholesky(A)) # Note a transposicao
L.inv <- matrix(0,3,3) 
I     <- diag(c(1,1,1))
for(i in 1:3){
  L.inv[,i] <- sistema.triang(L,I[,i])
} 
L.inv
t(L.inv)%*%L.inv

#====================================================
# Utilizando a funcao do R

solve(A)

solve(chol(A))%*%solve(t(chol(A)))

#====================================================
# Fim
#====================================================


