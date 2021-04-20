# Gráficos

library(tidyverse)
#install.packages("poliscidata")
library(poliscidata)

banco <- nes

# gráficos tem 3 elementos: dados, estética e geometria(representação visual)

banco$libcon3

# uso da função do pacote tidyverse

ggplot(banco, aes(x = libcon3)) + 
  geom_bar()
  
# organzando de acordo com a frequencia

ggplot(banco, aes(x = fct_infreq(libcon3))) + 
  geom_bar()

# mostrar proporção dos casos em vez da frequência usando labels

install.packages("scales")
library(scales)

ggplot(banco, aes(x = fct_infreq(libcon3), ..count../sum(..count..))) + 
  geom_bar() +
  scale_y_continuous(labels = percent)

# histograma/distribuição das observações

banco$obama_therm

ggplot(banco, aes(obama_therm)) +
  geom_histogram()


# especificando a quantidade de barras(bins), agregando as barras

ggplot(banco, aes(obama_therm)) +
  geom_histogram(bins = 10)

# especificando o comprimento da barra, ou seja, o intervalo de valores agregados em cada bin

ggplot(banco, aes(obama_therm)) +
  geom_histogram(binwidth = 10)


# curva de densidade

ggplot(banco, aes(obama_therm)) +
  geom_density()

# personalizando curva de densidade, agregando distribuição. Por default, é adjust = 1

ggplot(banco, aes(obama_therm)) +
  geom_density(adjust = 10)

ggplot(banco, aes(obama_therm)) +
  geom_density(adjust = 0.1)


# juntando tipos de gráficos: no último tipo, é preciso demonstrar o tipo de demonstração do primeiro tipo de gráfico na variável y

ggplot(banco, aes(obama_therm)) +
  geom_density(adjust = 1) +  #adicionando adjust
  geom_histogram(aes(y = ..density..),
                 bins = 30)  # adicionando bins


# boxplot: linha dentro da caixa é a mediana e determina a posição de metade das observações, linhas das margens da 
# caixa representam o quartil 1 e 3 (25% e 75% das observações). As linhas horizontais representam valor mínimo e máximo.
# Caso apareçam pintinhos foras das linhas horizontais, eles representam outliers.

ggplot(banco, aes(obama_therm)) +
  geom_boxplot()


# violino: obrigatório variável estar no y. Mostra curva de densidade para todos os valores.

ggplot(banco, aes("",obama_therm)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75))
















