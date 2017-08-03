library(mvtnorm)
r_jk_values <- c(-.9, 0,.9,.99) ## Possiveis valores de correlacao
tam_amostras <- c(100,1000,10000) ## Tamanho das possiveis amostras

sjj <- 1 ## Variancia igual a 1
r_jk <- r_jk_values[1] ## Utilizando a primeira opcao de correlacao
R <- matrix(r_jk,3,3)
roh <- sqrt(sjj)
sqrt_delta <- diag(roh,3,3)

S <- sqrt_delta %*% R %*% sqrt_delta

