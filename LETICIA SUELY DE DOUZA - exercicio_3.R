
library(poliscidata)
library(tidyverse)

## Carregue o banco world do pacote poliscidata

library(poliscidata)

banco_world <- world

# Para mais detalhes sobre esses dados, digite ?world

?world
glimpse(banco_world)

###############################################################################

# Utilizando o banco world do pacote poliscidata, faça um histograma, um 
# boxplot e a curva de densidade da variável gini10. Descreva o que você pode 
# observar a partir deles.

banco_world$gini10
summary(banco_world$gini10, na.rm = T)
sd(banco_world$gini10, na.rm = T)

ggplot(banco_world, aes(gini10)) +
  geom_histogram(binwidth = 10)

# O gráfico permite observar a distribuição dos coeficientes de gini, e apresenta uma concentração dos casos por volta
# de 40.0. A média dos dados é 40,13, com 14/167 linhas sem dados válidos. Agrupei alguns dados para os dados ausentes
# serem tirados da visualização, mas os dado manteve sua interpretação visual.

ggplot(banco_world, aes(gini10)) +
  geom_density(adjust = 0.5)

# O gráfico também permite observar a distribuição dos gráficos, mas agora em termos de densidade. Para não perder o objetivo,
# mas não deitar de reportar as nuances da distribuição, escolhi ajustar a densidade em 0.5, onde é possível perceber
# locais onde os dados tem picos para além da média, como um pouco depois da média, ante se depois do 50.0 e antes do
# 60.0.

# juntando gráficos

ggplot(banco_world, aes(gini10))+
  geom_histogram(aes(y = ..density..),
                 binwidth = 10)       +
  geom_density( adjust = 0.5)
  
######################################################################################## 

ggplot(banco_world, aes(gini10)) +
  geom_boxplot()

banco_world[banco_world$gini10 == 74.30, 1]

# Com este gráfico, é possível identificar alguns dados além da distribuição média dos dados. Com ele, percebe-se que
# o desvio padrão não deve ser pequeno, dado o mín e máximo apontados pelas linhas horizontais. E de fato não é, 9.2.
# Como é costume nas distribuições normais, a mediana é próima da média. Há um caso outlier, que identifiquei como sendo
# a Namíbia, tendo um gini tão algo, apontando grande desigualdade no país, que fica fora do esperado na normalidade da
# distribuição dos dados.

# Faça um grafico que descreva a variável regime_type3 e descreva o resultado

banco_world$regime_type3

ggplot(banco_world, aes(fct_infreq(regime_type3))) +
  geom_bar()

# Neste gráfico, é possível ver que a maior parte dos países está codificado como Ditadura; o segundo lugar é ocupado
# por democracias parlamentaristas; depois, vem democracias presidenciais. Um número grande de observações estão sem
# classificação, passando de 30 casos.


# A partir da varável X do banco df abaixo
df <- data.frame(x = cos(seq(-50,50,0.5)))
# Faça os tipos de gráficos que representem esse tipo de variável
# comentando as diferenças entre elas e qual seria a mais adequada

df$x
summary(df$x)
sd(df$x)

ggplot(df, aes(x)) +
  geom_histogram()

ggplot(df, aes(x)) +
  geom_density()

ggplot(df, aes(x)) +
  geom_boxplot()


# O primeiro gráfico, histograma, pode ser útil para perceber com mais detalhes a distribuição dos gráficos, ou agrupá-los em certos intervalos.
# O segundo gráfico, densidade, já nos mostra uma ideia (nesse caos super suavisada) do comportamento das observações.
# Tanto no primeiro, como no segundo gráfico, o objetivo é mostrar a distribuição dos dados, que é bimondal, contendo dois picos/concentração de observações.
# O terceiro gráfico mostra que o comportamento dos dados não tem outliers, e que o desvio padrão não é tão alto. A mediana é muito próxima de 0, e quase todos os dados estão dentro do primeiro e terceiro quartil.
# Apesar de parecer homogêneo, não há nada de homogêneo nesses dados.


# Carregue o banco states que está no pacote poliscidata 

banco_states <- states 

# Carregue o banco nes que está no pacote poliscidata

banco_nes <- nes 

# As variáveis conpct_m e ftgr_cons medem o nível de conservadorismo dos
# respondentes. A diferença é que o nes é um banco de
# dados com surveys individuais e o states é um banco de dados
# com informações por estado
# Faça um gráfico para ambas as variáveis. Comente as conclusões que podemos ter
# a partir deles sobre o perfil do eleitorado estadunidense.

banco_states$conpct_m

ggplot(banco_states, aes(conpct_m)) +
  geom_density(adjust = 0.1)

ggplot(banco_states, aes(conpct_m)) +
  geom_boxplot()

banco_nes$ftgr_cons

ggplot(banco_nes, aes(ftgr_cons)) +
  geom_density(adjust = 0.2)

ggplot(banco_nes, aes(ftgr_cons)) +
  geom_boxplot()

# Ambos os gráficos trazem conclusões sobre a polarização política que assola os EUA. Apesar dos dados agregados por Estado demonstrarem
# posicionamentos ligeiramente ligados à uma centro-esquerda, é possível perceber picos consideráveis mais à esquerda e também mais à direita.
# Quando olhamos para os dados individuais, os posicionamentos tem seu pico mais próximo ao meio do especto ideológico, mas também apresenta
# picos bastante homogêneos à esquerda e à direita. Ambos os dados mostram que os posicionamentos mais à direita, e portanto mais conservadores,
# tem sido ligeiramente mais expressivos. Não há outliers.
# O país permanece concentrado no centro ideológico, mas as forças de esquerda e direita são expressivas, sendo marcantes 
# em locais onde o voto não é obrigatório e em contextos de crises, onde a insatisfação geral traz estímulos a eleitor 
# mediano para desistir de votar, abrindo espaço para os partidos políticos ou líderes extremos oportunistas.
