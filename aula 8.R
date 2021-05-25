# Testes estatísticos de pressupostos da regressão

library(tidyverse)
library(poliscidata)

# simulando dados pra verificar os resultados

x <- rnorm(1000, 0, 1)

y <- 0+ x + rnorm(1000, 0, 1)

reg <- lm(y ~ x)
summary(reg)



# teste da lineariadade: se o gráfico apresentar uma comportamento linear dos pontos, bom.

qplot(x, y)

# outro exemplo de teste: argumento é regressão e 1 indica o tipo de gráfico. Ele apresenta o valores preditos e
# os resíduos. A linha vermelha deve ser reta e próxima à linha pontilhada para que seja perfeitamente linear.
plot(reg, 1)

# relação não linear:
y2<- x^2 + rnorm(1000, 0, 1)

qplot(x, y2)

reg_problema <- lm(y2 ~ x)
summary(reg_problema)

plot(reg_problema, 1)


###################################

# teste de homocedasticidade

x <- rnorm(1000, 5, 1)

y <- x + rnorm(1000, 0, 1)

reg <- lm(y ~ x)
summary(reg)

# No gráfico, há os valores preditos e os resíduos padronizados. A linha vermelha precisa
# ser horizontal e com os pontos distribuídos homogeneamente
plot(reg, 3)

# Nesse caso, em vez de olhar a linha vermelha, observa-se a distribuição dos pontos: se estiverem iguais acima e
# abaixo da linha, ele é homocedástico.
plot(reg, 1)

# relação não linear

y2 <- x + rnorm(1000, 0, sqrt(x^1.3))

reg_problema <- lm(y2 ~ x)
summary(reg_problema)

plot(reg_problema, 3)
plot(reg_problema, 1)

# testes com hipótese nula de que o modelo é homocedástico. Quanto maior o p-valor, mais chances de ser homocedástico.

library(lmtest)

bpteste(reg)
bpteste(reg_problema)

library(car)

ncvTest(reg)
ncvTest(reg_problema)

# Corrigindo modelos heterocedásticos: heterocedasticidade interfere no intervalo de confiança. Eles se tornam 
# não otimizados.
confint(reg_problema)

# Para corrigir isso, essas funções modicam e corrigem os intervalos de confiança. O Beta permanece igual, mas o
# erro padrão e o p-valor mudam, se tornando mais precisos.

library(sandwich)

coeftest(reg_problema,
         vcov = vcovHC(reg_problema, type = "HC3"))


###################################

# teste de autocorrelação entre casos e resíduos

# O gráfico pede que as linhas verticais estejam dentro dos intervalos das linhas azuis horizontais, com exceção
# da primeira.
acf(reg$residuals) # especifica os resíduos da regressão

# O resultado traz a hipótese nula de que não há autocorrelação entre resíduos. Quando maior o p-valor, melhor,
# pois não se rejeita a hipótese nula.
durbinWatsonTest(reg)

# modelo problemático: muita autocorrelação
y_alt <- 2^x + seq(1:1000)

reg_alt <- lm(y_alt ~ x)

acf(reg_alt$residuals)

durbinWatsonTest(reg_alt)

###################################


# teste de normalidade dos resíduos

# O gráfico deve apresentar observações muito próximos da linha pontilhada.
plot(reg, 2)


# O teste tem a hipótese nula de que a normalidade existe. O que se espera é um p-valor alto para não rejeitar a hipótese nula.
library(MASS)

residuos <- studres(reg)
shapiro.test(residuos)

# Modelo problemático: anormalidade dos resíduos
plot(reg_problema, 2)

residuos_problema <- studres(reg_problema)
shapiro.test(residuos_problema)

