#Multicolinearidade

# Matriz de correlação entre variáveis de uma base.
cor()

# Teste de variance inflation factor: retorna o vif de todas as variáveis dependentes. Seu valor mínimo é 1, indicando
# que não há multicolinearidade. Um valor alto para o VIF é relativamente arbitrário e alguns critérios consideram 
# que já representa uma colinearidade alta.
library(car)
vif() 

# Selecionando uma amostra: aumenta amostras pode resolver multicolinearidade, já que diminui erro padrão e, portanto
# seu intervalo de confiança e p-valor.
banco %>% sample_n()



# Outliers e Influencial cases
# Resíduo é a distância entre o valor predito e o observado, distância do ponto para a reta no eixo y. Se o resíduo 
# é discrepante, é uma indicação de um resíduo grande ou não.
# O leverage é a medida em que os casos se distanciam na média do eixo x. Se compara se a observação, no eixo
# x, tem valores muito diferentes dos casos de comportamento médio. 
# Observação influente: ao tirar a observação da regressão, a linha da regressão muda consideravelmente.

reg <-lm(y ~ x, banco)

# Visualiza resultado da regressão, alternativa ao summary. Ele dá o valor observado de y, de x e o valor predito
# (.fitted), resíduos, leverage(.hat) - nesses dois, é a medida em si, então quanto maior, pior é a observação
# para o modelo -, DFFIT(.sigma), .cooksd - esses dois são medidas de influência dados pela diferença do observado 
# e predito -, e resíduo padronizado.
library(broom)
augment(reg)

# cook distance:quanto maior as linhas, verticais, maior a influência das observações.
plot(reg, 4)

# Observação de influência caso as observações ultrapassem os intervalos de confiança.
plot(reg, 5)

# DFBETA: stabelece um valor crítico pelas linhas vermelhas. Se as linhas azuis passarem delas, o dfbeta é grande 
# e classifica a observação como influente.
library(olsrr)
ols_plot_dfbetas(reg, print_plot = F)

# Apresente leverage e resíduos padronizado. Observações fora dos limites do grupo azul pra cima mostram
# resíduos altos. Fora do grupo azul pro lado mostram leverage alto. Quadrantes superor e inferior 
# direito são os casos influentes.
ols_plot_resid_lev(reg)

# cooks distance: se as linhas azuis passarem da linha vermelha, aquele caso é influente.
ols_plot_cooksd_chart(reg)

# dffit: linhas azuis que passam das linhas vermelhas são casos influentes.
ols_plot_dffits(reg)


#retirar observação:
library(tidyverse)
reg %>% 
  slice(-observação)
