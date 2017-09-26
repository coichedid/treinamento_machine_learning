## Atualiza a literatura das aulas com base na data de atualizacao
#wd <- getwd() 
#script.dir <- dirname(sys.frame(1)$file)
#setwd(script.dir)

file_sep <- .Platform$file.sep

carregaDependencias <- function() {
    if (!require(XML)) {
        install.packages("XML")
        library(XML)
    }
    if (!require(stringr)) {
        install.packages("stringr")
        library(stringr)
    }
    if (!require(hashmap)) {
        install.packages("hashmap")
        library(hashmap)
    }
}

## Parse data de atualizacao do site
## Compara com a ultima data de atualizacao 
estaAtualizado <- function(atualizacao, destino = paste(".","ultimaAtualizacao.rds",sep = file_sep)) {
    meses <- hashmap(c("janeiro","fevereiro","marco","abril","maio", "junho",
                       "julho","agosto","setembro","outubro","novembro","dezembro"),
                     1:12)
    
    ## Parse da data do site
    dataAtualizacao <- strsplit(atualizacao,":")[[1]][2]
    dataAtualizacao <- str_match(dataAtualizacao,"^ ([0-3]?[0-9]) de (.*), ([0-9]{4})\\.")
    dataAtualizacao[1,3] <- meses[[tolower(dataAtualizacao[1,3])]]
    dataAtualizacao <- as.Date(paste(dataAtualizacao[1,2],dataAtualizacao[1,3],
                                     dataAtualizacao[1,4]),"%d %m %Y")
    
    estaAtualizado <- F
    ## Recupera a ultima data salva
    if (file.exists(destino)) {
        ultimaAtualizacao <- readRDS (destino)
        estaAtualizado <- ultimaAtualizacao == dataAtualizacao
    }
    saveRDS(dataAtualizacao,destino)
    return(estaAtualizado)
}

## Define a ultima data de atualizacao para muito no passado
forcaAtualizacao <- function(destino = paste(".","ultimaAtualizacao.rds",sep = file_sep)) {
    d <- as.Date("01 01 1980","%d %m %Y")
    saveRDS(d,destino)
}

extraiHrefs <- function(no) {
    print("Outro n?")
    #print(no)
    h <- sapply(no["li"],function(el) {
        link <- xmlGetAttr(el[["p"]][["a"]],"href")
        link <- substring(link,3)
        paste(base_uri,
              link,
              sep = "/")
    })
    n <- sapply(no["li"],function(el) xmlValue(el[["p"]][["a"]]))
    names(h) <- c()
    names(n) <- c()
    m <- matrix(c(h,n),nrow = length(h))
    return(m)
}

download_without_overwrite <- function(url, folder)
{
    filename <- basename(url)
    base <- tools::file_path_sans_ext(filename)
    ext <- tools::file_ext(filename)
    
    file_exists <- grepl(base, list.files(folder), fixed = TRUE)
    
    if (any(file_exists))
    {
        filename <- paste0(base, " (", sum(file_exists), ")", ".", ext)
    }
    
    download.file(url, file.path(folder,filename), mode = "wb")
}

baixaArquivos <- function(doc, destino = paste(".",file_sep,sep = "")) {
    nos <- xpathSApply(doc,"//ul[@class = 'square']",function(el) el)
    hrefs <- sapply(nos,extraiHrefs)
    names(hrefs) <- c("Literatura","Aulas","Exemplos","Apoio","Octave","Dados")
    # print(hrefs)
    
    pastas <- names(hrefs)
    for(p in pastas) {
        destinoPasta <- paste(destino,p,sep = file_sep)
        if (!file.exists(destinoPasta)) dir.create(destinoPasta)
        files <- hrefs[[p]]
        apply(files,1,function(f) {
            url <- f[1]
            download_without_overwrite(url,destinoPasta)
        })
    }
}

carregaDependencias()
## Get destination folders
#print(pasta_default)
if (!exists("pasta_default")) {
  print("Onde est?o as pastas a serem atualizadas?")
  f <- readline(prompt = "Entre com o caminho completo das pastas, separadas por virgula: ")
  script.dir <- strsplit(f,",")[[1]]
} else script.dir <- c(pasta_default)



base_uri <- "http://www.im.ufrj.br/ralph"
uri <- paste(base_uri,"treinamento.html",sep = "/")

doc <- htmlTreeParse(uri,useInternalNodes = T)
atualizacao <- xpathSApply(doc,"//font[@face='Arial, Helvetica, sans-serif']/b",xmlValue)

for (s in script.dir) {
    f <- paste(s,"ultimaAtualizacao.rds",sep = file_sep)
    
    ## Comentar se n?o quiser for?ar a atualiza??o
    forcaAtualizacao(f)
    
    atualizado <- estaAtualizado(atualizacao, destino = f)
    
    if (!atualizado) {
        baixaArquivos(doc, destino = s)
    } else print("J? est? atualizado")
}
#setwd(wd)