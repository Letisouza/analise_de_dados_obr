# beta

# sum((x-mean(x)) * (y-mean(y)) / sum(((x-mean(x))* 2))
    
# alpha
    
# mean(y) - (beta * mean(x))

# regressão linear

# rl <- lm(y ~ x)
# summary(rl)

# confint(rl)  -  utiliza o erro padrão para calcular o intervalo de confiança com 95%. A partir dele, é possível ver se os
# valores de beta e intercepto obedecem os intervalos.

# y - predict(rl)

# interpretação dos dados

# dados de resíduos, com média muito próxima de zero; coeficientes das variáveis, erro padrão (utilizado pra calcular o 
# intervalo de confiança, aumentando ou diminuindo a depender do intervalo desejado), valor t e p-valor; 
# residual standard error: Erro do modelo em média de pontos (distância dos pontos em relação à linha) dada a escala da variável, 
# R² (capacidade de explicação do modelo sobre a variação da variável dependente), R² ajustado (melhor em reg múltipla).

####################################

library(poliscidata)
library(tidyverse)

banco_nes <- nes

cor.test(banco_nes$obama_therm, banco_nes$conservatism)

# gráfico de dispersão

qplot(banco_nes$conservatism, banco_nes$obama_therm) +
  geom_jitter (alpha = 0.1) +
  geom_smooth(method = "lm") # linha de tendência de ajuste aos dados, e o argumento força linha reta.

# regressão linear 

reg <- lm(obama_therm ~ conservatism, data = banco_nes)
summary(reg)

# calcular intervalo de confiança das variável independete e intercepto

confint(reg)


########################################################


# Importação de bancos de dados

getwd() # mostra a pasta de referência do arquivo

setwd("") # determina em as aspas os local da pasta onde se quer guardar os arquivos (nas barras "\", colocar duas barras ou uma barra /)


# abrindo xls 

library(readxl)

read_excel("nome do arquivo.xlsx") 

# em caso de planilhas com várias planilhas, por default de abre a primeira. Para especificar:

read_excel("nome do arquivo.xlsx", sheet = x) # x é o número da planilha ou nome da planilha)


# especificando apenas algumas colunas ou linhas para carregar

read_excel("nome do arquivo.xlsx", sheet = x,
           range = call_cols("A:J"), # selecionando colunas
           range = call_rows(1:8), # selecionando linhas
           range = "A1:J8")        # selecionando colunas e linhas ao mesmo tempo


# salvando dados 

library(writexl)

write_xlsx(banco, "Nome do arquivo a ser salvo.xlsx") # salva este arquivo na pasta de referência. Se for outra, especificar antes no nome do arquivo.


# abrindo csv

library(tidyverse)

read_csv(banco, "nome do arquivo.csv") # célula separadas por vírgula

read_csv2(banco, "nome do arquivo.csv") # célula separada por ponto e vígula


# salvando

write_csv(banco, "nome do arquivo.csv") ou write_csv2(banco, "nome do arquivo") # ou indicando ainda a pasta caso necessite antes do nome do arquivo.



# abrindo sas (stata)

read_sas()
write_sas()

#abrindo sav (spss)

read_sav()
write_sav()


# dados da web

url < - "link"

download.file(url, "nome desejado do arquivo.tipo de arquivo", mode = "wb")

# abrindo este arquivo

banco <- read_excel("nome do arquivo.xlsx")


###########################


# juntando bancos de dados

library(poliscidata)

estados <- states

survey <- nes

# une, no banco de referência, as bases, mantendo todas as linhas do banco à esquerda e unindo às colunas adicionais do outro banco pra elas. Deve crescer em número de colunas e manter observações.

survey_merged <- left_join(survey, estados,
                           by = c("sample_state" = "stateid"))


# unir as bases com base no que elas têm em comum da variável de referência, excluindo linhas. Aumenta colunas e dominui ou mantém linhas.

survey_merged2 <- inner_join(survey, estados,
                             by = c("sample_state" = "stateid"))




