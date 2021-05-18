# Variáveis categóricas e interativas

library(poliscidata)
library(tidyverse)

banco <- nes

reg <- lm(obama_therm ~ conservatism + polknow_combined, banco)
summary(reg)

confint(reg)

                    # Binária #

# a categoria é omitida nos resultados automaticamente, sendo ela a referencia.

reg2 <- lm(obama_therm ~ conservatism + polknow_combined + gender, banco)
summary(reg2)


ggplot(banco, aes(conservatism, obama_therm))+
  geom_jitter(apha = 0.1) +
  geom_smooth(method = "lm")

# Interpretação: Em média, a categoria aprsentada apresenta um aumento(diminuição) de Beta estimado na VD em relação à outra categoria omitida.
# O intercepto, logo, indica o valor atribuído à VD quando o genero for homem (0)

# para mudar a categoria de referencia, categoria codificada como 0, precisa-se mudar a ordem do fator, fct_relevel().

banco2 <- banco %>% 
  mutate(gender = fct_relevel(gender, "Female"))

reg3 <- lm(obama_therm ~ conservatism + polknow_combined + gender, banco2)
summary(reg3)

# O intercepto, que agora indica VD em média quando for uma mulher, soma o intercep de reg2 com o beta estimado de female em reg 2.

#################################

           # Mais de duas categorias #
# Uma das categorias é omitida automaticamente, sendo a referência.

reg4 <- lm(obama_therm ~ conservatism + polknow_combined + gender + dem_raceeth, banco)
summary(reg4)

# Interpretação: Os betas das categorias imprimem uma aumento(diminuição) da média da VD em relação à categoria de referência.
# O p-valor dá a significência da diferença entre a categoria de referência e a categoria analisada.

library(sjPlot)

plot_model(reg4)

# Pelo gráfico, é possível ver uma comparação entre todas as categorias sem necessariamente precisar rodar novos modelos.
# Visualmente, por exemplo, é possível ver que negros apoiam mais que todas as outras categorias indicadas, e outros apoia menos que as outras categorias apresentadas no modelo.
# Também é possível ver a significância das categorias com a de referencia pela linha de 0. Se não cruzar zero, é significante.
# Quando o intervalo de confiança (linhas horizontais) das variáveis se sobrepoem, as categorias entre si não possuem diferença em relação à categroia de referencia.

# Mudando categorias: checando estimadores e p-valor comparado à hispanicos.

banco2 <- banco %>% 
  mutate(dem_raceeth = fct_relevel(dem_raceeth, "3. Hispanic"))

reg5 <- lm(obama_therm ~ conservatism + polknow_combined + gender + dem_raceeth, banco2)
summary(reg5)

plot_model(reg5)

# GRAFICOS: apresentam as retas do modelo para cada categoria. A diferença entre elas é o intercepto.

library(moderndive)


ggplot(banco, aes(conservatism, obama_therm))+
  geom_jitter(apha = 0.1) +
  geom_parallel_slopes(aes(color=gender), se = F)


ggplot(banco, aes(conservatism, obama_therm))+
  geom_jitter(apha = 0.1) +
  geom_parallel_slopes(aes(color=dem_raceeth), se = F)


################################


        # Interação entre Variáveis #

# A interação entre variáveis une efeitos de variáveis interativas, de modo que as retas dos gráficos acima não iam paralelas.
# Para homens, por exemplo, o nível de efeito da outra variável(conservadorismo) em aprovação de obama pode ser maior que para 
# mulheres, não permitindo escontância apresentada pelo intercepto que torna as retas paralelas.

# Interação: Categórica e numérica

reg_interacao <- lm(obama_therm ~ conservatism + polknow_combined + gender + dem_raceeth + conservatism * gender, banco)
summary(reg_interacao)

# Interpretação: para valores isolados da interação, o beta será a aprovação de Obama quando a outra variável da interação for 0.
# Ou seja, o beta de genderfemale apresenta a provação em média de obama de mulheres, em relação a homens, quando o conservadorismo for 0.
# O beta de conservadorismo apresenta a aprovação em média de obama quando genderfemale for zero, ou seja, quando for um homem.
# A partir de uma tabela interativa, as variáveis isoladas já não apresentam seus efeitos isolados, mas sim moderando pela outra variável de dentro da interação.
# A interação, portanto, apresenta o beta de aprovação de obama, em media, quando estivermos tratando de uma mulher conservadora.

plot_model(reg_interacao, type = "pred", # Type apresenta os valorer ´preditos da regressão para VD
          terms = c("conservatism", "gender"), # variaveis interagindo, numerica antes de categorica
           banco)

# no fim do gráfico, é possível ver que os intervalos de conaça (sombra das retas) se soprepoem.
# Isso prova que a interação não possui significãncia estatística, indicando que não há diferença entre homens e mulheres conservadores na aprovação de obama.




# Interação: numérica e numérica

reg_interacao2 <- lm(obama_therm ~ conservatism + polknow_combined + gender + dem_raceeth + conservatism * polknow_combined, banco)
summary(reg_interacao2)

#Interpretação: isoladas, conservadores com baixo conhecimento político; pessoas com alto conhecimento político e com conservadorismo baixo. 
# Na interação, efeito médio de obama quando se trata de um conservador com alto conhecimento político.

plot_model(reg_interacao2, type = "pred", # Type apresenta os valorer ´preditos da regressão para VD
           terms = c("polknow_combined", "conservatism"), # variaveis interagindo, numerica antes de categorica
           banco)
#Comparação vertical(entre linhas) e horizontal(na propria linha)

# Cada linha apresenta casos de conservadorismo dado o conhecimento político para aprovação de obama.
# Nenhum intervalo de confiança se sobrepoe verticalmente, então a interação é estatisticamente significante.
# Contudo, para cada reta, é preciso olhar a horizontalidade das retas. No caso da reta vermelha, ela tem intervalo de confiança
# que se sobrepoe nos extremos, indicando que pra os não conservadores, conhecimento ppolítico não interfere na aprovação.
# Pra quem é muito conservador, a aprovação muda dado o conimento político.



# Interação: categórica e categórica

reg_interacao3 <- lm(obama_therm ~ conservatism + polknow_combined + gender + dem_raceeth + gender * dem_raceeth, banco)
summary(reg_interacao3)


plot_model(reg_interacao3, type = "pred", # Type apresenta os valorer ´preditos da regressão para VD
           terms = c("gender", "dem_raceeth"), # variaveis interagindo, numerica antes de categorica
           banco)


# Interpretação:  É possível ver para cada grupo de raça, o efeito do genero na aprovação de obama.
# Nos isolados, vale a interpretação quando a outra variável da interação for zero.

# No gráfico, cabe uma interpretação vertical, entre grupos. Quando não se sobrepoem, há diferença entre os generos. Aqui, há   diferença entre negros e hispanicos, tanto pra homens quanto pra mulheres.
# Numa interpretação horizontal, entre genero, da mesma forma. Aqui, há diferença entre homen e mulheres negros e brancos.

plot_model(reg_interacao3, type = "pred", # Type apresenta os valorer ´preditos da regressão para VD
           terms = c("dem_raceeth", "gender"), # variaveis interagindo, numerica antes de categorica
           banco)

