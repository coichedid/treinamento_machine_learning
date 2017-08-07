# Treinamento Métodos Gaussianos de Aprendizagem de Máquina
___
## Exercício Aula 1

> Escreva um programa no R para gerar números do vetor aleatório
normalmente distribuído com variâncias todas iguais a 1 (um) e
correlações todas iguais a um dos valores no conjunto
{−0, 9; 0, 0; 0, 9; 0, 99}, e varie o tamanho das amostras geradas para
cada matriz de covariâncias (por exemplo, 100, 1000, etc).  
Considere
uma normal trivariada para este exercício. Faça diversos gráficos para
analisar os conjuntos de dados gerados. Por exemplo box-plot,
histogramas, qq-plot, dispersão dois a dois, etc. É importante neste
exercício que você trabalhe com a matriz de dados de acordo com a
parte teórica da matéria, ou seja, salve os dados gerados em uma
matriz p × n.  
Dica: verificar as funções boxplot, *hist*, *qqnorm* e *plot* do programa R.

O exercício solicita uma distribuição normal trivariada. Desta forma, o número *p* de variáveis é **3**.  
No enunciado também foi definido que a variância **s** é **1**.  
Assim, temos como variáveis iniciais:  

| Variável | Valor |  
| -------- |:-----:|  
| *p*      | 3     |  
| *s*      | 1     |  
| *r*      | {-.9,0,.9,.99} |  
| *n*      | {100,1000,10000} |  

Para iniciar o exercício, primeiro é preciso encontrar a matriz de covariância **&#931;**. Ela é obtida pela equação ![eq_sigma](gifs/eq_sigma.gif)  
Os passos para calcular a matriz **&#931;** a partir da Variância e Correlação são:
1. Criar uma matriz de correlação **R**
  1. Definir uma matriz *p*X*p* com valores iguais à correlação escolhida
  2. Definir a diagonal da matriz **R** para 1, pois a matriz de correlação tem diagonal 1 (correlação entre um elemento e ele mesmo **r<sub>ii<sub>**)
2. Calcular o desvio padrão **&#961;** igual a ![sqrt(s)](gifs/eq_sigma.gif)
3. Calcular  ![delta_meio](gifs/delta_meio.gif) igual a matriz diagonal de **&#961;**
