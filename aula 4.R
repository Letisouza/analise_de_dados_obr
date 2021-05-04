# Testes de hipóteses

library(tidyverse)
library(poliscidata)

banco_nes <- nes

banco_nes$gender

# Correlação (R²) entre variáveis: antes de calcular, traçar um gráfic de dispersão.

cor(banco_nes$obama_therm, 
    banco_nes$conservatism, use = "complete") # opção menos completa

cor.test(banco_nes$obama_therm, 
         banco_nes$conservatism)

# Resultado - p-valor: 2.2^-16: 0.00000000000000022; Intervalo de confiança: permanece sem ultrapassar o 0. Correlação: -0.65.





# Teste-t para diferença de médias em amostras pareadas(iguais).

banco_nes %>% 
  group_by(gender) %>% 
  summarise(media = mean(obama_therm, na.rm = T))
  
t.test(obama_therm ~ gender, data = banco_nes)  # primeiro variável numérica, depois a categórica
 
# Resultado: média: por grupo. p-valor: 0.000000000000007; Intervalo de confiança: permanece sem ultrapassar o 0,  a diferença
# entre as médias varia nesse intervalo (em módulo).
 
# Em caso de variáveis categóricas com mais de 2 categorias, temos uma ANOVA. É preciso usar as duas funções seguintes:

teste_anova <-aov(obama_therm ~ dem_raceeth4, data = banco_nes)
summary(teste_anova)

# Resultado - P-valor: muito pequeno. Não mostra a diferença entre os grupos, mas SE apenas uma das combinações for significante,
# o p-valor será significativo.

#Teste Tukey

TukeyHSD(teste_anova)

#Resultado -  diferença entre cada grupos em comparação. Mostra também o intervalo de confiança.





# qui-quadrado: teste entre variáveis categóricas

chisq.test(banco_nes$obama_vote, banco_nes$gender)

# Resultado - p-valor: pequeno e significativo. 

###################################################



# Gráficos bivariados


banco_nes <- banco_nes %>% 
  remove_missing(vars = "pres_vote12") # observações missing nessa variável saem da base.


# duas variáveis categóricas (2 ou mais)

#gráfico de barras indicados pela cor em quem votaram. 

ggplot(banco_nes, aes(gender, fill = pres_vote12)) + #a segunda variável fica nas cores distribuídas em gênero.
  geom_bar(position = "fill")


ggplot(banco_nes, aes(pres_vote12, fill = gender)) + #a segunda variável fica nas cores distribuídas em quem votou.
  geom_bar(position = "fill")

# count vira uma proporção, não uma contagem.


# qui-quadrado: gráfico

library(vdc)

tabela <- table(banco$free_overall, banco$hi_gdp)

# mostra associação entre cada grupo de variáveis

assoc(table, shade = T)






# variáveis categorica(2 ou mais) e contínua: nível de conservadorismo impactando no voto

ggplot(banco_nes, aes(conservatism, fill = pres_vote12)) + # fill é a categórica
  geom_density()

# distribuição de conservadorismo que votaram em cada candidato. Mas as curvas se sobrepõem. Para corrigir:

ggplot(banco_nes, aes(conservatism, fill = pres_vote12)) + # fill é a categórica
  geom_density(alpha = 0.3) # quanto mais perto de 0, mais transparente ficam as cores.


ggplot(banco_nes, aes(conservatism, pres_vote12)) +
  geom_boxplot()

ggplot(banco_nes, aes(pres_vote12, conservatism)) +
  geom_boxplot()

# A caixa dos dois não se sobrepõem, mostranso a diferença entre os candidatos e o nível de conservadorismo associado
# a eles. A meadiana de conservadorismo de quem votou em Romney é maior que quem votou em Obama, tendo também mais variação.
# A mediana divide 50% dos votos.

ggplot(banco_nes, aes(pres_vote12, conservatism)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75))


# gráfico pra anova: Quemuel

a<-banco%>%select(gini08, free_overall_4)
a<-Rmisc::summarySE(a,"gini08","free_overall_4",na.rm = T)

a%>%na.omit%>%ggplot(aes(free_overall_4, gini08))+
  geom_bar(stat="identity")+
  geom_errorbar(aes(ymin=gini08-sd, ymax=gini08+sd))







# variáveis numéricas

# gráfico de ponto: dispersão

ggplot(banco_nes, aes(obama_therm, conservatism)) +
  geom_point()

# alguns pontos estarão em cima de outros. Para resolver isso:

ggplot(banco_nes, aes(obama_therm, conservatism)) +
  geom_point(alpha = 0.1) # deixar os pontos mais transparentes.


ggplot(banco_nes, aes(obama_therm, conservatism)) +
  geom_jitter(alpha = 0.1) # deixa os pontos um pouco mais deslocados para o lado quando há concentração de casos no 
# mesmo local, de forma que é possível ver melhor a distribuição.



# Melhorando aparências

library(ggthemes)

ggplot(banco_nes, aes(obama_therm, conservatism)) +
  geom_jitter(alpha = 0.1) +
  theme_minimal() + # limpa o fundo do gráfico e esclaresce as linhas
  theme_classic() # tira linhas do fundo e a cor cinza
  

ggplot(banco_nes, aes(obama_therm, conservatism)) +
  geom_jitter(alpha = 0.1) +
  theme_tufte() # limpa linhas e cores do fundo do gráfico


ggplot(banco_nes, aes(pres_vote12, conservatism)) +
  geom_tufteboxplot() # tira as caixas, deixando um ponto para mediana. Somem os outliers.


ggplot(banco_nes, aes(pres_vote12, conservatism)) +
  geom_tufteboxplot(median.type = "line",
                    whisker.type = "line",
                    hoffset = 0, width = 3)


ggplot(banco_nes, aes(conservatism, fill = pres_vote12)) + # fill é a categórica
  geom_density(alpha = 0.3) +
  scale_fill_ptol() + # mudar cores default
  labs(title = "figura 1",
       subtitle = "gráfico de curva de densidade",
       x = "Conservadorismo",
       y = "densidade",
       caption = "Elaborado pelos autores a partir do banco NES") +
  theme(axis.text.x = element_text(angle = 45)) # mudando o texto do eixo x

# Como mudar legendas de variáveis categoricas?
# Como ajustar a escala de valores?







