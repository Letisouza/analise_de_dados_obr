
# Carregue no R o banco de dados que está no seguinte endereço:
# https://github.com/MartinsRodrigo/Analise-de-dados/raw/master/04622.sav

library(haven)

url <- "https://github.com/MartinsRodrigo/Analise-de-dados/raw/master/04622.sav"

download.file(url, "atv_github_rodrigo.sav", mode = "wb")

banco <- read_sav("atv_github_rodrigo.sav")

ESEB <- banco

# Este banco de dados é o ESEB 2018, com dados eleitorais coletados por survey.
# Para mais detalhes sobre este banco, ver o seguinte endereço:
# https://www.cesop.unicamp.br/por/eseb/ondas
# A variável Q1607 indica uma nota de 0 a 10 ao candidato Jair Bolsonaro. 
# A variável Q18 indica uma auto-atribuição em uma escala ideologica de 
# 0 a 10, da esquerda para a direita.
# Valores acima de 10 nestas duas variáveis representam respostas não uteis 
# para nossa pesquisa.
# Mantenha no banco de dados as observações que possuam apenas valores válidos
# para estas variáveis

library(tidyverse)

ESEB_mod <- ESEB %>% 
  filter(Q1607 <= 10,
         Q18 <= 10)

ESEB_mod$Q1607
ESEB_mod$Q18


# Represente graficamente cada uma destas variáveis e descreva o resultado

ggplot(ESEB_mod, aes(Q1607, ..count../sum(..count..))) +
  geom_bar() +
  theme_classic() +
  labs(x = "Aprovação de Bolsonaro",
       y = "Porcentagem")
#  O gráfico representa a porcentagem de pessoas presentes em cada nível da escala. 0, 5 e 10 são os níveis da escala com
# mais respondentes, com <20%, <10% e <30% respectivamente. A maioria absoluta se localiza em 10, dando absoluta aprovação ao Presidente.
# Para melhorar a visuzalização e trazer uma ideia melhor da distribuição, fiz o boxplot.

ggplot(ESEB_mod, aes(Q1607)) +
  geom_boxplot() +
  theme_classic() +
  labs(x = "Aprovação de Bolsonaro",
       y = "")

# O boxplot apresenta que a maior parte dos respondentes está entre, aproximadamente, 1 e 7.


ggplot(ESEB_mod, aes(Q18, ..count../sum(..count..))) +
  geom_bar() +
  theme_classic() +
  labs(x = "Escala ideológica",
       y = "Porcentagem")

# O gráfico acima representa a distribuição de respondentes sobre sua ideologia. Mais uma vez, os dados se espalham entre 0(esquerda), 5(centro)
# e 10(direita), com >10%, <20% e <40% respectivamente. É possível perceber que de 5 a 10 há substancialmente mais respondentes.


ggplot(ESEB_mod, aes(Q18)) +
  geom_boxplot() +
  theme_classic() +
  labs(x = "Escala ideológica",
       y = "")

# Pelo boxplot, confirmamos que a metade dos respondentes se acumulam no aspectro mais á direita, especilamente entre 7 e 10.

# Represente graficamente a associação entre estas duas variáveis e descreva
# o resultado

ggplot(ESEB_mod, aes(Q18, Q1607)) +
  geom_jitter(alpha = 0.1) +
  theme_classic() +
  labs(x = "Escala ideológica",
       y = "Aprovação de Bolsonaro")


# Pelo gráfico, é possível que os dados estão bastante dispersos. As partes mais escuras indicam uma concentração maior de respondentes,
# o que significa um certo alinhamento entre os níveis das variáveis. Por exemplo, a massa mais escura representam respondentes que são
# 10 na escla aideologica e 10 em aprovação de Bolsonado, indicando que muitos respondentes de direita aprovam o governo. No geral, há um
# acúmulo claro de respondentes de centro a direita que consideram o governo bolsonaro bom em algum nível.



# Faça um teste estatístico bivariado que teste a associação entre estas variáveis
# Qual é a sua conclusão?

cor.test(ESEB_mod$Q18, 
         ESEB_mod$Q1607)


# O teste de correlação entre as variáveis mostra um p-valor extremamente significativo e um intervalo de confiança que comporta o nível
# de associação apresentado: 0.353. A correlação, apesar de positiva, indicando crescimento acompanhado das variáveis, é bastante baixo.
# É difícil indicar que a relação não explique algo sobre as variáveis, mas é importante perceber que a associação é fraca.



# Faça uma regressão linear onde a variável dependente é a aprovação de Bolsonaro
# (Q1607) e a variável independente é a auto-atribuição ideológica (Q18)


reglin <- lm(Q1607 ~ Q18, ESEB_mod)
summary(reglin)

qplot(ESEB_mod$Q18, ESEB_mod$Q1607) +
  geom_jitter (alpha = 0.1) +
  geom_smooth(method = "lm") +
  theme_classic() +
  labs(x = "Escala ideológica",
       y = "Aprovação de Bolsonaro")

# Interprete o resultado da regressão (coeficientes, p-valores, medidas de ajuste)

# O coeficiente do intercepto é próximo de 3.00, com p-valor bastante significativo. Isso indica que se o candidato for de esquerda,
# a aprovação de bolsonaro cai para 3. O coeficiente da VI, ideologia, é 0.40, também com p-valor bastante significativo. Isso indica
# que quanto mais á direita na escala, a aprovação de Bolsonaro cresce em 0.40 na escala.
# Ao observar a média de resíduo dos dados, vemos que é próxima de 0, mas sua proximidade com 1 pode quebrar um dos principais
# pressupostos da regressão. 
# O erro méddio do modelo é de 3.6, indicando que essa é a distância média dos pontos em relação à reta. Já o R² é 0.125, representando
# uma capacidade muito pequena de explicação do modelo (12,5% da variação da variável dependente)


# Verifique o intervalo de confiança dos coeficientes


confint(reglin)

# Os intervalos de confiança são respeitados pela variável independente(entre 0.36 e 0,45) e intercepto(entre 2.64 e 3.37).
