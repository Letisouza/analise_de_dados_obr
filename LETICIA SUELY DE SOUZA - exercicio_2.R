
# No pacote poliscidata existe um banco de dados chamado nes, com informa??es 
# do American National Election Survey. Para os exer?cicios a seguir, instale 
# o pacote poliscidata e tidyverse, carregue-os e crie um objeto chamado
# df com os dados do nes. 
library(tidyverse)

library(poliscidata)

df <- nes
head(df)

# Fa?a uma primeira explora??o do banco de dados com todos os comandos
# passados at? aqui que possuem esse objetivo

str(df)
glimpse(df)
summary(df)


# Quantos respondentes possui na pesquisa?

5916


# Caso queiram ter mais informa??es sobre as vari?veis do nes, basta rodar
# o c?digo `?nes`, que no canto inferior direito aparecer? uma descri??o.
# Como temos muitas vari?veis, deixe apenas as colunas
# ftgr_cons, dem_raceeth, voted2012, science_use, preknow3, obama_vote
# income5, gender.

df_select <- df %>% 
  select(ftgr_cons, 
         dem_raceeth, 
         voted2012, 
         science_use, 
         preknow3, 
         obama_vote,
         income5, 
         gender)


# Se quisermos ter informa??es apenas de pessoas que votaram na
# elei??o de 2012, podemos usar a vari?vel voted2012. Tire do banco
# os respondentes que n?o votaram

df_select$voted2012

df_2012 <- df_select %>%
  select(ftgr_cons, 
         dem_raceeth, 
         voted2012, 
         science_use, 
         preknow3, 
         obama_vote,
         income5, 
         gender) %>% 
  filter(voted2012 == "Voted")
  
df_2012$voted2012

# Quantos respondentes sobraram?

4404


# Crie uma vari?vel chamada white que indica se o respondente ? branco
# ou n?o a partir da vari?vel dem_raceeth, crie a vari?vel ideology a
# partir da vari?vel ftgr_cons (0-33 como liberal, 34 a 66 como centro,
# e 67 a 100 como conservador), ao mesmo tempo em que muda
# a vari?vel obama_vote para trocar o 1 por "Sim" e 0 por "n?o"

df_2012$dem_raceeth
df_2012$ftgr_cons
df_2012$obama_vote

df_2012_modificado <- df_2012 %>% 
  mutate(white = recode(dem_raceeth,
                        "1. White non-Hispanic" = "White",
                        "2. Black non-Hispanic" = "non-White",
                        "3. Hispanic" = "non-White",
                        "4. Other non-Hispanic" = "non-White"),
         ideology = case_when(ftgr_cons <= 33 ~ "liberal",
                              ftgr_cons > 33 & ftgr_cons <= 66 ~ "centro",
                              ftgr_cons > 66 & ftgr_cons <= 100 ~ "conservador"),
         obama_vote = case_when(obama_vote == 1 ~ "Sim",
                                obama_vote == 0 ~ "Não"))

df_2012_modificado$white
df_2012_modificado$ideology
df_2012_modificado$obama_vote

# Demonstre como observar a quantidade de pessoas em cada uma das
# categorias de science_use

df_2012_modificado$science_use

df_2012_modificado %>% count(science_use)


# Demonstre como observar a m?dia de conservadorismo (vari?vel 
# ftgr_cons) para cada categoria de science_use

df_2012 %>%  
  group_by(science_use) %>% 
  summarise(mean(ftgr_cons, na.rm = "T"))
  

###############################################################################

# Responder as quest?es te?ricas da aula abaixo

# Observar a figura 1.2 do livro Fundamentals of Political Research e
# fazer o mesmo esquema para o trabalho final de voc?s (ou projeto de pesquisa).

Resposta

# Populismo nativista __________________________________________________________________________________ Legislações migratórias
                           
#      O populismo nativista está bastante associado ao populismo de extrema-direita, que apesar de não 
#     necessariamente serem parte de uma mesma configuração de populismo, possuem interseções quanto à 
#     intolerância (Bergmann, 2020). Essa combinação pauta uma preferência mais restritiva quanto a 
#     políticas de admissão e integração de imigrantes (Lutz, 2018)


#                 a) O populismo nativista influencia os posicionamentos restritivos a imigrantes;
#                 b) Na Índia, a influência do nativismo para restrição a imigrantes é maior que no Brasil.


# posicionamentos e discursos dos líderes _______________________________________________________________ leis, decretos e programas direcioandos à imigrantes



# Qual ? a disponibilidade de dados para sua pesquisa? J? existem bancos de 
# dados prontos? Voc? tem acesso a eles? Caso a ?ltima pergunta seja positiva, 
# responda o exer?cio 4 do cap?tulo 5.

Resposta

# Já que meus dados são qualitativos, e ainda não os tenho coletados, vou fazer sobre os dados do QoG.

# a) o banco é feito com o auxílio de vários especialistas sobre qualidade de governo, contendo informações
# sobre uma série de tópicos, como educação, justiça, meio-ambiente, instituições, etc.

# b) o banco cobre mais de 100 países, desde a década de 1980 até 2020.

# c) observando a mensuração de fragiliade estatal, parece bastante confiável, visto que mede a nível 
#institucional e padronizado todos os países. Talvez a única forma de melhorar o dado seria adaptando 
#para cada país com informações de facto.

# d) o dado parece bastante válido, medindo o que muitos consideram aspectos de um Estado frágil. Não consigo
# pensar em formas de como melhorar sua validade.



# Qual seria a forma ideal e mais adequada de operacionalizar suas
# vari?veis para testar sua hip?tese? Escreva sobre a confiabilidade e validade
# que suas vari?veis possam vir a ter

Resposta

# Como são variáveis qualitatvas, as variáveis são medidas através de discursos e falas que, teoricamente embasadas,
# refletem um direcionamento no caminho populista e de restrição a imigrantes. No caso das legislações,
# o dado se torna mais confiável e válido, dado que seus desdobramentos indicam seu significado. No caso dos
# discursos, que incluem tradução e momento político, a validade e a confiabilidade podem ser comprometidas
# pela má interpretação de certas falas. Mas utilizando bons métodos, isso pode ser remediado.
