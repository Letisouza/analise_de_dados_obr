library(poliscidata)
library(tidyverse)

banco <- nes %>% 
  select(obama_therm,
         conservatism,
         spsrvpr_ssself,
         ftcasi_white,
         ftcasi_asian)

#testando correlação entre todas as variáveis do banco 
cor(banco, use = "complete.obs")

# extra: função de correlação com grafico e p-valor
cor.plot(insig = "p-value")
#

#testando a significância das correlações.
cor.test(banco$obama_therm, banco$spsrvpr_ssself)
cor.test(banco$obama_therm, banco$conservatism)
cor.test(banco$conservatism, banco$spsrvpr_ssself)

# reg linear: usando pipe pra não precisar salvar o objeto e já dar o resultado.

lm(obama_therm ~ conservatism, banco) %>% summary()

lm(obama_therm ~ spsrvpr_ssself, banco) %>% summary()

# reg linear multipla: mudança nos betas e nos intervalos de confiança

lm(obama_therm ~ conservatism + spsrvpr_ssself, banco) %>% summary()
lm(obama_therm ~ conservatism + spsrvpr_ssself, banco) %>%  confint()

# Importante: aqui, R² ajustado é mais importante que o R², visto que avalia por variável em vez de pelo modelo inteiro.

# visualização de resultados de regressão em forma de gráfico
library(sjPlot)

# salvando modelo completo
reg_completa <- lm(obama_therm ~ conservatism + spsrvpr_ssself, banco)

# plotando o modelo
plot_model(reg_completa)
# eixo x: coeficientes. Linhas horizontais indicam intervalo de confiança do coeficiente.
# Linha banca mais grossa: indica o valor 0 (pontos abaixo, relação negativa. Pontos acima, relação positiva). Se 
# algun coeficiente/intervalo de confinaça cruzar a linha, ele não terá significência estatística.
# Neste caso, Pontos vermelhos: direção negativa. Pontos azuis: direção positiva.

# padronização por desvio padrão: conservadorismo tem mais impacto
plot_model(reg_completa, type = "std")

###########################################