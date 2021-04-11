
# Entre no seguinte link:
# https://pt.wikipedia.org/wiki/Eleição_presidencial_no_Brasil_em_2002
# Vá até o tópico RESUMO DAS ELEICOES
# Crie um vetor com o nome dos seis candidatos a presidência

candidatos <- c("Lula", "Serra", "Garotinho", "Ciro", "José", "Rui")

# Crie um vetor com a sigla do partido de cada candidato

partido <- c("PT", "PSDB", "PSB", "PPS", "PSTU", "PCO")

# Crie um vetor com o total de votos de cada candidato
  
votos_candidatos <- c(39.4, 19.7, 15.1, 10.1, 0.402, 0.38)

# Crie um objeto calculando a soma do votos dos candidatos no 1o turno
  
total_votos <- 84.9

# Crie um vetor com a porcentagem de votos de cada candidato
# fazendo uma operação aritmética entre o objeto votos_candidatos
# e o objeto total_votos

porcentagem_votos <- c(votos_candidatos[1]/total_votos*100, votos_candidatos[2]/total_votos*100, votos_candidatos[3]/total_votos*100, votos_candidatos[4]/total_votos*100, votos_candidatos[5]/total_votos*100, votos_candidatos[6]/total_votos*100)
porcentagem_votos

# Crie um dataframe com o nome dos candidatos, o partido,
# a quantidade de votos e o percentual
base_eleicao <- data.frame(candidatos,
                           partido,
                           votos_candidatos,
                           porcentagem_votos)
str(base_eleicao)
head(base_eleicao)
  
# Crie um vetor lógico, indicado TRUE ou FALSE, com a informacao se
# o candidato foi para o segundo turno

segundo_turno <- c(T, T, F, F, F, F)

# Adicione esta coluna no dataframe

base_eleicao$segundo_turno <- c(T, T, F, F, F, F)

head(base_eleicao)

# Calcule a soma da porcentagem dos dois candidatos que obtiveram mais votos

base_eleicao[1,4] + base_eleicao[2,4]

# Exiba as informações do dataframe dos dois candidatos com mais votos

base_eleicao[base_eleicao$segundo_turno == TRUE, ]

###############################################################################

# Substitua o símbolo de interrogação por um 
# código que retorne o seguinte resultado:
#
# [1] 24 18 31

q <- c(47, 24, 18, 33, 31, 15)
q[c(2, 3, 5)]

###############################################################################

# Substitua o símbolo de interrogação por um 
# código que retorne o seguinte resultado:
#
# 'data.frame':	2 obs. of  2 variables:
# $ x: Factor w/ 2 levels "d","e": 1 2
# $ y: num  1 4

df1 <- data.frame(x = factor(c("d", "e")),
                   y = c(1, 4))

str(df1)

###############################################################################

# Crie o seguinte dataframe df
#
# df
#    x  y    z
# 1 17  A  Sep
# 2 37  B  Jul
# 3 12  C  Jun
# 4 48  D  Feb
# 5 19  E  Mar

df <- data.frame(x = c(17, 37, 12, 48, 19), 
                 y = c("A", "B", "C", "D", "E"), 
                 z = c("Sep", "Jul", "Jun", "Feb", "Mar"))
head(df)

# Ainda utilizando o dataframe df,
# qual código produziria o seguinte resultado?
#
#    x  y
# 1 17  A
# 2 37  B
# 3 12  C

df[1:3, 1:2]


###############################################################################

# Responder os exercícios teóricos abaixo
# A partir do seu projeto de mestrado ou da ideia de trabalho final:
# 1) elaborar uma explicação causal teórica

#   O populismo nativista está bastante associado ao populismo de extrema-direita, que apesar de não necessariamente serem 
#   parte de uma mesma configuração de populismo, possuem interseções quanto à intolerância (Bergmann, 2020). Essa combinação 
#   pauta uma preferência mais restritiva quanto a políticas de admissão e integração de imigrantes (Lutz, 2018) 


# 2) elaborar hipóteses

#  a) O populismo nativista influencia os posicionamentos restritivos a imigrantes;
#  b) Na Índia, a influência do nativismo para restrição a imigrantes é maior que no Brasil.



# 3) pensar em como operacionalizar os conceitos teóricos em variáveis empíricas

#  Populismo: posicionamentos e discursos dos líderes.
#  Restrição à imigrantes: leis, decretos e programas direcioandos à imigrantes.

# 4) estabelecer o tipo de relação entre as variáveis operacionalizadas

#   A relação seria positiva: quanto mais posicionalementos populistas, mais elemtnos restritivos são notados.


# 5) elabore qual é a pergunta da sua pesquisa em apenas uma frase

#  Quais as semelhanças e diferenças na questão da imigração entre potências emergentes com governos populistas de 
#  extrema-direita nativistas e não-nativistas?



# 6) avalie em que medida seu projeto, por enquanto, pode vir a passar pelas 4 
# avaliações de relação causal, e quais problemas ele pode ter em cada uma delas

# regra 1: há um mecanismo causal.
# regra 2: é possível descartar que y causa x.
# regra 3: as variáveis covariam, visto qur são correlacionadas.
# regra 4: não controlamos por todas as variáveis, mas a literatura estabelece que a relação entre as duas variáveis, em certos 
# contextos, como na Índia, é muito forte.