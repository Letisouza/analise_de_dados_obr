library(poliscidata)
library(tidyverse)
library(sjPlot)

banco <- nes

# Linear Probability Model
reg_lpm <- lm(obama_vote ~ conservatism + polknow_combined + gender + dem_raceeth, banco)

summary(reg_lpm)

# Interrpetação: em termos de probabilidade, aumentando ou diminuindo em beta por cento na média da VD a cada variação em 1 unidade de VI.

# Valores preditos
qplot(reg_lpm$fitted.values)

plot_model(reg_lpm)



# Regressão logística (logit)
reg_log <- glm(obama_vote ~ conservatism + polknow_combined + gender + dem_raceeth, 
               banco, 
               family = 'binomial')
summary(reg_log)


# Transformando os betas em chance

# Apenas valores estimados
coef(reg_log)

# Exponencial dos coeficientes
exp(coef(reg_log))

# Intervalo de confinaça dos coeficientes não convertidos
confint(reg_log)

# Intervalos de confiança em exponencial
exp(confint(reg_log))

# Une colunas dos coeficientes e dos intervalos de confiança, trasnformando tudo em exponencial
exp(cbind(coef(reg_log), confint(reg_log)))

library(broom)

tidy(reg_log, exponenciate = T, conf.int = T)

plot_model(reg_log) # Intervalos de confinaça não podem cruzar 1.

# Interpretação exponencial: o beta é a chance de sucesso na VD em um aumento de uma unidade da VI.
# Valores acima de um representam chance positiva(aumenta a chance) em VD, e valores menores que um representam a chance nagtiva(diminui a chance) em VD
# A cada aumento de unidade da VI, a chance de sucesso aumenta em beta vezes.A cada aumento de unidade da VI, a chance de sucesso diminui em 1/beta vezes. 

# Transformando chance em porcentagem: Há também a possibilidade de utilizar os valores exponenciais e fazer operações para percentagem, diminuindo 1 do beta e multiplicando por cem, tanto pra aumento ou diminuição de chance.
# Beta - 1 * 100

# Transformação de chance em probabilidade
library(margins)

margins_summary(reg_log)
# Calcula o efeito médio das variáveis na VD.
# Interpretação: mudança em uma unidade na VI gera um efeito médio de beta*100 no sucesso na VD.
# Esse efeito médio pode ser falado em termos de probabilidade também.

# Avaliação de desempenho dos modelos:
# Os R² não fazem sentido, então a forma de avaliar se o modelo funciona bem, se prever bem quem vota ou não em obama

# Probabilidade de acerto na predição da VD.
predicted_prob <- predict(reg_log, type = "response")

library(informationvalue)

# Aponta a porcentagem em proporção de erro da predição do modelo.
misClassError(banco$obama_vote,
              predicted_prob,
              threshold = 0.5) # Acima do thrashold, votou em obama. Abaixo, não votou.

# Aponta a porcentagem em proporção de acerto da predição do modelo.
1 - misClassError(banco$obama_vote,
                 predicted_prob,
                 threshold = 0.5)

# Aponta o melhor valor de threshold
opt_cutoff <- optimalCutoff(banco$obama_vote,
                            predicted_prob)

misClassError(banco$obama_vote,
              predicted_prob,
              threshold = opt_cutoff)

# A matriz de confusão apresenta o número de observações corretas e erradas pelo modelo em cada categoria. Ela, por default, assume o threshold de 0.5.
confusionMatrix(banco$obama_vote,
                predicted_prob)

confusionMatrix(banco$obama_vote,
                predicted_prob,
                opt_cutoff) %>% prop.table() # Para a matriz em termos de proporção.

# Sensibilidade é o percentual de casos que tem a característica de interesse(sucesso) corretamente preditos pelo modelo. Também é possível mudar o threshold.
sensitivity(banco$obama_vote, predicted_prob)

# Especificidade é o percentual de casos que não tem a característica(sucesso) de interesse e que foram corretamente preditos pelo modelo. Também é possível mudar o threshold.
specificity(banco$obama_vote, predicted_prob)

library(pscl)

# Forma alternativa de medir um pseudo R². As 3 últimas medidas da saída demonstram esse dado.A interpretação é parecida como sempre, mas eles não são necessariamente a porcentagem da explicação da variação da VD, mas são aproximações disso.
# G2 é uma medida que compara o likelihood do modelo com variáveis com o modelo nulo(apenas com intercepto). Quanto maior, melhor.
# llh e llhnull são os likelihoods dos modelos completos e nulos respectivamente. Para esses, quanto menor o llh, melhor.
pR2(reg_log)







