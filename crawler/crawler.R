## Atualiza a literatura das aulas com base na data de atualizacao
library(XML)

uri <- "http://www.im.ufrj.br/ralph/treinamento.html"

doc <- xmlTreeParse(uri,useInternalNodes = T)
root <- xmlRoot(doc)



