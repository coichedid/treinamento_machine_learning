library(mvtnorm)

compara.correlacoes <- function(sigma,normal,correlacao) {
    # Usando a decomposicao de Cholesky
    T <- chol(sigma)
    y <- normal%*%T
    data.frame(cov.normal=cor(y),sigma=sigma,num.amostra=nrow(normal),correlacao=correlacao)
}

calcula.sigma <- function(variancia,correlacao) {
    sjj <- variancia ## Variancia igual a 1
    r_jk <- correlacao ## Utilizando a primeira opcao de correlacao
    R <<- matrix(r_jk,3,3)
    diag(R) <<- 1 ## Matriz de correlacao tem 1 como diagonal
    roh <- sqrt(sjj) ## Desvio padrao
    delta_meio <- diag(roh,3,3)
    
    delta_meio %*% R %*% delta_meio ## Retorna Sigma
    
}

matriz.eh.positiva.definida <- function(m) {
    e <- eigen(m)$values >= 0 ## Matriz positiva definida tem auto valores >= 0
    all(e)
}

analisa.matriz <- function(cor.index,tam.amostra,save.image = FALSE) {
    r_jk_values <- c(-.9, 0,.9,.99) ## Possiveis valores de correlacao
    tam_amostras <- c(100,1000,10000) ## Tamanho das possiveis amostras
    
    cor.selected <- r_jk_values[cor.index]
    num.amostras <- tam_amostras[tam.amostra]
    
    Sigma = calcula.sigma(1,cor.selected)
    if (matriz.eh.positiva.definida(Sigma)) { ## para simular a normal Sigma deve ser positivo e definido
        if (save.image) {
            if (!file.exists("./images")) dir.create("./images")
        }
        w <<- rmvnorm(num.amostras,mean = c(0,0,0),sigma = Sigma)
        ## Plot graphics
        if (save.image) png(paste("./images/","pairs_",cor.selected,"_",
                                  num.amostras,".png",sep = "")) else quartz()
        pairs(w,pch=15) ## dispersão 2 a 2
        if (save.image) dev.off()
        
        if (save.image) png(paste("./images/","densidade_",cor.selected,"_",
                                  num.amostras,".png",sep = "")) else quartz()
        ## comparacao de densidades
        #displayMatrix <<- matrix(c(1,1,1,2,2,2,3,4,5,6,7,8),4,3,byrow=T)
        #layout(displayMatrix)
        #par(mfrow=c(2,1))
        d1 <- density(w[,1])
        d2 <- density(w[,2])
        d3 <- density(w[,3])
        lty = rep(1,each=3)
        lwd = rep(2.5,each=3)
        
        plot(d1,main = "density")
        lines(d2,col="red")
        lines(d3,col="blue")
        legend("topright",legend = c("1st dim","2nd dim","3rd dim"),
               col = c("black","red","blue"),
               lty = lty, lwd = lwd)
        if (save.image) dev.off()
        
        
        if (save.image) png(paste("./images/","hist_",cor.selected,"_",
                                  num.amostras,".png",sep = "")) else quartz()
        ## comparacao de histogramas
        hist(w[,1],col=rgb(0,1,0,1)) 
        hist(w[,2],add=T,col = rgb(1,0,0,1/2))
        hist(w[,3],add=T,col=rgb(0,0,1,1/4))
        legend("topright",legend = c("1st dim","2nd dim","3rd dim"),
               col = c("green","red","blue"),
               lty = lty, lwd = lwd)
        if (save.image) dev.off()
        
        
        if (save.image) png(paste("./images/","boxplot_",cor.selected,"_",
                                  num.amostras,".png",sep = "")) else quartz()
        ## comparacao boxplot
        #quartz() ## Boxplot e QQNorm plot de cada dimensão  
        par(mfrow=c(1,3))
        boxplot(w[,1], main = "1st dim")
        boxplot(w[,2], main = "2nd dim")
        boxplot(w[,3], main = "3rd dim")
        if (save.image) dev.off()
        
        
        if (save.image) png(paste("./images/","qqnorm_",cor.selected,"_",
                                  num.amostras,".png",sep = "")) else quartz()
        par(mfrow=c(1,3))
        ## comparacao QQNorm de cada dimensao
        qqnorm(w[,1], main = "1st dim")
        qqline(w[,1],col="red") 
        qqnorm(w[,2], main = "2nd dim")
        qqline(w[,2],col="red")
        qqnorm(w[,3], main = "3rd dim")
        qqline(w[,3],col="red")
        if (save.image) dev.off()
        return(compara.correlacoes(Sigma,w,cor.selected))
    } else {
        cat("Matriz Sigma não é positiva e definida\n")
        return()
    }
}

save <- TRUE
comparacao <- data.frame()
analisa.matriz(1,1,save.image = save) ## Sigma não é positiva definida

## Segundo valor de correlacao (0.0)
comparacao <- rbind(comparacao,analisa.matriz(2,1,save.image = save))  
comparacao <- rbind(comparacao,analisa.matriz(2,2,save.image = save))
comparacao <- rbind(comparacao,analisa.matriz(2,3,save.image = save))

## Terceiro valor de correlacao (0.9)
comparacao <- rbind(comparacao,analisa.matriz(3,1,save.image = save)) 
comparacao <- rbind(comparacao,analisa.matriz(3,2,save.image = save))
comparacao <- rbind(comparacao,analisa.matriz(3,3,save.image = save))

## Quarto valor de correlacao (0.99)
comparacao <- rbind(comparacao,analisa.matriz(4,1,save.image = save)) 
comparacao <- rbind(comparacao,analisa.matriz(4,2,save.image = save))
comparacao <- rbind(comparacao,analisa.matriz(4,3,save.image = save))

comparacao <- split(comparacao,list(comparacao$correlacao,comparacao$num.amostra))