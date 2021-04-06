#operações

5+5
5-5
5*5
5/5
5^5

#objetos: coisas que são criadas

adicao <- 5+5
adicao

subtracao <- 5-5
subtracao

multiplicacao <- 5*5
multiplicacao

divisao <- 5/5
divisao

#tipos de dados

numerico <- 42
texto <- "texto"
logico <- TRUE
FALSE

#funções: determninam ações com os objetos

class(numerico)

class(texto)

class(logico)

#vetor: objetos com mais de um elemento usando função combine. Cada vetor tem elementos do  mesmo tipo.

vetor_numerico <- c(1, 2, 3, 4, 5)
vetor_numerico
i <- c(1:5)
i

vetor_textual <- c("segunda", "terça", "quarta", "quinta", "sexta")
vetor_textual

vetor_logico <- c(TRUE, FALSE, T, F, F)
vetor_logico

segundo_numerico <- c(10, 11, 12, 13, 14)
segundo_numerico

#operação com objetos e vetores

adicao + divisao

adicao + texto #erro pois não são da mesma classe

vetor_numerico + segundo_numerico #relaciona primeiro elemento de um com o primeiro elemento do outro, etc. Caso os vetores tenham quantidades de elementos distintos, o menor repete para compensar o maior.

#seleção de elementos do vetor: [posição do elemento] ou [c(posição dos elementos)]

vetor_numerico[4]

vetor_textual[1]

vetor_numerico[c(4,5)]

#indicar elementos onde a condição lógica se encaixa ou não

vetor_numerico > 3
vetor_numerico < 3
vetor_numerico == 3
vetor_numerico >= 3
vetor_numerico[vetor_numerico > 3] #retorna os elementos em si que respondem à condição

#Fator: transformando objetos/vetores em fator, útil para transformar elementos de texto em numérico. Níveis indicam a quantidade de elementos distintos, e a ordem dos elementos destacadas no retorno é a ordem de niveis, que pode ser mudada da ordem alfabética (default)

partido <- c("pt", "psdb", "pt", "psdb", "pmdb")
partido <- factor(partido)
partido

ou 

#especificar os níveis e os labels dos elementos
partido2 <- factor(c("pt", "psdb", "pt", "psdb", "pmdb"),
                   levels = c("pt", 
                              "psdb",
                              "pmdb"),
                    labels = c("Partido dos Trabalhadores",
                               "Partido da social democracia do Brasil",
                               "Partido da mobilização democrática brasileira"))
partido2

#Dataframes: um conjunto de vetores unificados em um objeto, organizados em linhas e colunas.

iris #a base possui 5 vetores (colunas)

head(iris) #retorna as primeiras linhas
tail(iris) #retorna as últimas linhas

str(iris) #retorna a estrutura do banco de dados: quantidade observações(linhas), de variáveis(colunas), etc
View(iris) #retorna uma planilha com os dados da base (se o banco for muito grande, isso pode prejudicar o uso deo R)

banco <- iris

summary(banco) #retorna informações de estatísitca básica para cada coluna. Quando a variável for fator, há retorno da quantidade de cada categoria.

#selecionando colunas em um dataframe: nome do banco$nome da coluna 

banco$Species #retorna os dados de determinada coluna

banco$Sepal.Length * banco$Sepal.Width #operação entre duas colunas

#criando dataframes: une vetores em um dataframe com a ordem de como cada vetor é colocado na função. Cada vetor precisa ter o mesmo tamanho/quantidade de elementos e se relacionar com a mesma observação de outro vetor.

banco2 <- data.frame(vetor_numerico,
                     vetor_logico, 
                     vetor_textual)
banco2

#selecionando elementos em um dataframe: [posição da linha e da coluna]

banco2[3, 3]

banco2[banco2$vetor_numerico > 2, 2] #seleciona, da coluna indicada pelo $, os elementos das linhas que correspondem à condição em relação à coluna indicada. Ou seja, das linhas da condição, retorna os elementos das colunas.
banco2[ ,3] #retorna a terceira coluna inteira
banco2[3, ] #retorna a terceira linha inteira


