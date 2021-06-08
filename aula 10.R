# Viés de variável omitida e proxy

# ver correlação das variáveis
cor.test(banco$v1, banco$v2)

# corrigindo viés de variável omitida: proxy
cor.test(banco$v2, bancoproxy$v2proxy)

# ver modelos com vies de omitida e com proxy
plot_models(regvies, regproxy)

###############################################

# Transformação de variável

# log
lm(y ~ log(x))

# exponencial
lm(y ~ exp(x))


library(poliscidata)
library(tidyverse)

qplot(log(world$gdp08))
ggplot(world, aes(log(gdp08)))+
  geom_density()

ggplot(world, aes(literacy, gdp08)) +
  geom_jitter(alpha = 0.5) +
  geom_smooth(se = F)

ggplot(world, aes(literacy, log(gdp08))) +
  geom_jitter(alpha = 0.5) +
  geom_smooth(se = F,method = "lm")


reg <- lm(gdp08 ~ literacy, world)

plot(reg, 2)

reglog <-  lm(log(gdp08) ~ literacy, world)

plot(reglog, 2)

summary(reglog) # log linear
# Interpretação y em log: o beta representa a mudança percentual que uma unidade de x gera na média de y. Neste caso,
# multiplica-se o coeficiente por 100.

reglogdummy <-  lm(log(gdp08) ~ literacy + democ_regime08, world)
summary(reglogdummy)
exp(beta da variável dummy)
# Interpretação com y em log e variável dummy: é necessário transformar o beta em exponencial, indicando a diferença 
# da mediana de Y nos casos das categorias de referência. Nesse caso, países democráticos tem uma mediana de 1.23 a
# mais em seu pib em comparação com países não democráticos.

reglog2 <- lm(log(gdp08) ~ log(pop_total), world)
summary(reglog2) # log log
# Interpretação com y e x log: o beta representa a mudança percentual que um ponto percentual em x gera na média de y.
# Neste caso, utiliza-se o valor apresentado pelo coeficiente.

reglog3 <- lm(literacy ~ log(gdp08), world)
summary(reglog3) # linear log
# Interpretação com x em log: o beta representa a mudança que um ponto percentual em x gera na média de y. Neste caso,
# divide-se o coeficiente por 100.


####################################################

# Gráficos multivariados

library(ggthemes)

banco<-world

# especificando a terceira variável pelo tamanho dos pontos
ggplot(banco, aes(dem_score14, gini08, size = gdppcap08)) +
  geom_jitter() +
  theme_minimal()

# especificando a terceira variável pela cor dos pontos: numérica
ggplot(banco, aes(dem_score14, gini08, color = hdi)) +
  geom_jitter(size = 5) +
  theme_minimal()

# especificando a terceira variável pela cor dos pontos: categórica
ggplot(banco, aes(dem_score14, gini08, color = regime_type3)) +
  geom_jitter(size = 3) +
  theme_minimal()

# especificando a terceira variável pelo formato dos casos: categórica
ggplot(banco, aes(dem_score14, gini08, shape = hi_gdp)) +
  geom_jitter() +
  theme_minimal()

# especificando a terceira variável pela divisão em painéis diferentes: categórica
ggplot(banco, aes(dem_score14, gini08)) +
  geom_jitter(size = 3) +
  facet_wrap(vars(regime_type3))

# especificando a terceira variável pela divisão em painéis diferentes horizontais: categórica
ggplot(banco, aes(dem_score14, gini08)) +
  geom_jitter(size = 3) +
  facet_grid(regime_type3 ~ .)

# especificando a terceira variável pela divisão em painéis diferentes verticais: categórica
ggplot(banco, aes(dem_score14, gini08)) +
  geom_jitter(size = 3) +
  facet_grid(. ~ regime_type3)

# especificando as terceira e quarta variáveis pela divisão em painéis diferentes horizontais e verticias: categórica
ggplot(banco, aes(dem_score14, gini08)) +
  geom_jitter(size = 3) +
  facet_grid(hi_gdp ~ regime_type3)

# especificando as terceira, quarta e quinta variáveis por tamanho, cor e formato.
ggplot(banco, aes(dem_score14, gini08, 
                  size = gdppcap08, 
                  color = regime_type3, 
                  shape = hi_gdp)) +
  geom_jitter() +
  theme_minimal()



  