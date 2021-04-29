## Carregue o banco world do pacote poliscidata

library(poliscidata)
library(tidyverse)
library(ggthemes)

banco <- world

# Para mais detalhes sobre esses dados, digite ?world

?world

###############################################################################

## Queremos testar a relação entre a variável hi_gdp, que mede se um país 
## tem crescimento economico alto, e a variável gini08, que mede a desigualdade.

banco$hi_gdp
banco$gini08

## Qual teste seria adequado para verificar a associação entre estas variáveis?

# Considerando que a variável dependente é a desigualdade, e a variável independente é o crescimento do PIB, o teste
# seria o teste-t de diferença de médias.


## Realize o teste abaixo


t.test(gini08 ~ hi_gdp, data = banco)



## Quais são suas conclusões sobre a relação entre estas variáveis? Por que?

# A diferença entre as médias entre os grupos de PIB baixo e alto é de 4.08, estando dentro do intervalo de confiança
# mensurado. Com um p-valor de 0.02, é possível identificar que o resultado é significativo estatisticamente. A média de
# desigualdade em países com PIB alto é 38.3, enquanto que a desigualdade em países com PIB baixos tem uma média de 42.4.
# A associação vista é que menores PIB tendem a ser tidos com níveis de desigualdade maiores.



## Faça um gráfico que mostre a associação entre estas duas variáveis


ggplot(banco, aes(gini08, fill = hi_gdp)) +
  geom_density(alpha = 0.4) +
  theme_classic() +
  labs(x = "Desigualdade",
       y = "Densidade",
       fill = element_blank()) # mexer na legenda.


###############################################################################

## Queremos testar a relação entre a variável fhrate08_rev, que mede o nível de 
## democracia de um país, e a variável gini08, que mede a desigualdade.

banco$fhrate08_rev

## Qual teste seria adequado para verificar a associação entre estas variáveis?

# O teste seria de correlação de pearson, já que se tratam de duas variáveis numéricas.



## Realize o teste abaixo


cor.test(banco$fhrate08_rev,
         banco$gini08)


## Quais são suas conclusões sobre a relação entre estas variáveis? Por que?

# A correlação é negativa, -0,157. Apesar de bastante significativa, com o-valor de 0.08, a correlação é bem baixa. Isso
# indica que o nível de democracia de um país cresce enquanto a desigualdade diminui, sendo uma relação intuitiva. Contudo
# por ser uma relação muito fraca, é difícil trazê-la como algo importante para explicar algum evento.



## Faça um gráfico que mostre a associação entre estas duas variáveis

ggplot(banco, aes(fhrate08_rev, gini08)) +
  geom_point() +
  theme_classic() +
  labs(x = "Nível de democracia",
       y = "Desigualdade")



###############################################################################

## Queremos testar a relação entre a variável free_overall_4, que mede a 
## liberdade economica de um país, e a variável gini08, que mede a desigualdade.

banco$free_overall_4

## Qual teste seria adequado para verificar a associação entre estas variáveis?

# O teste ideal seria o teste ANOVA de diferença de médias, dado que a variável independente, liberdade
# econômica, é categórica e possui mais de 2 níveis.


## Realize o teste abaixo

ANOVA <- aov(gini08 ~ free_overall_4, data = banco)
summary(ANOVA)
TukeyHSD(ANOVA)

## Quais são suas conclusões sobre a relação entre estas variáveis? Por que?

# O p-valor é bastante significativo, 0.006, mas o modelo só tem diferença de gini significativa para dois casos: 
# entre liberdades altas e pequenas e entre liberdade altas e médias pra altas. Nesses grupos, o p adj foi significativo.
# Com exceção desses grupos, nenhuma outra combinação possui uma diferença que signifique uma mudança real no gini com
# base no nível de liberdade econômica.


## Faça um gráfico que mostre a associação entre estas duas variáveis


ggplot(banco, aes(free_overall_4, gini08)) +
  geom_boxplot() +
  theme_classic() +
  labs(x = "Liberdade econômica",
       y = "Desigualdade")


###############################################################################

## Queremos testar a relação entre a variável free_overall_4, que mede a 
## liberdade economica de um país, e a variável hi_gdp, que mede se um país 
## tem crescimento economico alto

## Qual teste seria adequado para verificar a associação entre estas variáveis?

# O teste ideal seria o qui-quadrado, onde é possível comparar a média de variáveis categóricas.



## Realize o teste abaixo

chisq.test(banco$hi_gdp, banco$free_overall_4)



## Quais são suas conclusões sobre a relação entre estas variáveis? Por que?

# O resultado traz um p-valor muito pequeno, menor que 0.000. Isso implica que a diferença entre a média liberdade econômica
# para países com alto ou baixo PIB é significativa, ou seja, os grupos de liberdade econômica estão muito bem distribuídos
# nos grupos de PIB alto ou baixo, havendo associação entre essas variáveis. No caso, quanto maior a liberdade, maior é o PIB.



## Faça um gráfico que mostre a associação entre estas duas variáveis

ggplot(banco, aes(free_overall_4, fill = hi_gdp)) +
  geom_bar() +
  theme_classic() +
  xlab("Liberdade Econômica") +
  ylab("Frequência") +
  labs(fill = "PIB")


