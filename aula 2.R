# Manipulação de banco de dados

# funções base do r
head()
tail()
summary()
str()

# funções em pacotes (no CRAN do R)

install.packages("tidyverse") # instalando pacotes
library(tidyverse) # carregar pacotes para uso

install.packages("poliscidata") # dados úteis para as aulas. Link: https://cran.r-project.org/web/packages/poliscidata/index.html
library(poliscidata)

banco_gss <- gss
str(banco_gss)
glimpse(banco_gss) # demonstração das colunas como vetores e seus elementos

########################################################################

# Seleção de colunas usando o tidyverse

banco_gss_selecionado <- banco_gss %>% # pipe
  select(age, born, degree, sex, authoritarianism)


banco_gss_selecionado1 <- banco_gss %>%
  select(starts_with("ab")) # seleciona colunas que comecem com ab

#######################################################################

# Filtrando linhas usando o tidyverse

banco_gss$born # Para ver a variável

banco_filtrado <- banco_gss %>%
  filter(born == "YES") # mantém o número de variáveis e seleciona apenas as observações filtradas para elas que respondem à condição.

banco_gss$sex # Para ver a variável

banco_filtrado_sex <-  banco_gss %>%
  filter(born == "YES",
         sex == "Female") # mantém o número de variáveis e seleciona apenas as observações filtradas para elas que respondem às duas condições.

######################################################################

# Modificando e adicionando colunas à base

banco__gss_novo <- banco_gss %>%
  mutate(ano_nascimento = 2012 - age) # criando colunas novas com variáveis do banco

banco__gss_novo$ano_nascimento # Para ver a variável 

# Renomando colunas

banco_gss_renomeado <- banco_gss %>%
  rename(voto_presidencial = pres08) # Renomeia uma coluna e guarda essa base nova em substituição da base original

banco_renomeado <- banco_gss %>% 
  select(age, born, degree, sex, authoritarianism,  # Seleciona e renomeia variáveis
          voto_presidencial = pres08)

# Recodificando variáveis existentes

case_when() # usado em variáveis quando há necessidade de uam condição.
recode() # usado em variáveis categóricas, para mudar nomes/textos

banco_gss$polviews

banco_recodificado <- banco_gss %>%
  mutate(polviews = recode(polviews,     # modifica a variável indicada recodificando os valores dessa coluna
                           ExtrmLib = "Extremely Liberal",
                           SlghtLib = "Slightly Liberal",
                           SlghtCons = "Slightly Conservative",
                           Conserv = "Conservative",
                           ExtremCons = "Extremely Conservative"))

banco_recodificado$polviews

# Criando categorias de idade

banco_recodificado <- banco_gss %>%
  mutate(age = case_when(age < 20 ~ "Menos de 20",  # modificando variáveis de modo que, seguindo a condição, as linhas em que age é menor que 20, passará a ter esse texto
                         age >= 20 & age < 30 ~ "De 20 a 29",
                         age >= 30 & age < 40 ~ "De 30 a 39",
                         age >= 40 & age < 50 ~ "De 40 a 49",
                         age >= 50 & age < 60 ~ "De 50 a 59",
                         age >= 60 ~ "Idoso")) 


banco_recodificado$age

#################################################################

# Sequência de ações com o pipe: cada função abaixo segue as instruções da função anterior


banco_gss_pipe <- banco_gss %>% 
  select(age, born, degree, sex, authoritarianism, pres08, polviews) %>% 
  filter(born == "YES") %>% 
  mutate(ano_nascimento = 2021 - age,
         polviews = recode(polviews,     # modifica a variável indicada recodificando os valores dessa coluna
                           ExtrmLib = "Extremely Liberal",
                           SlghtLib = "Slightly Liberal",
                           SlghtCons = "Slightly Conservative",
                           Conserv = "Conservative",
                           ExtremCons = "Extremely Conservative")) %>% 
  rename(voto_presidencial = pres08)

##################################################################

# Contar observações em cada categoria das variáveis

banco_gss_pipe$degree

banco_gss_pipe %>% 
  count(degree)      # frequência de cada categoria da degree. A função count() só funciona para variáveis categóricas

banco_gss_pipe %>%    # Cria uma nova variável contendo um cálculo estatítico de uma variável numérica existente.
  summarise(media = mean(authoritarianism, na.rm = TRUE),
            mediana = median(authoritarianism, na.rm = TRUE),
            desvio_padrao = sd(authoritarianism, na.rm = TRUE),
            minimo = min(authoritarianism, na.rm = TRUE),
            maximo = max(authoritarianism, na.rm = TRUE)) 


banco_gss_pipe %>% 
  group_by(degree) %>% # Agrupa pela variável indicada e retorna os valores estatísticos requisitados para cada categoria dela
  summarise(media = mean(authoritarianism, na.rm = TRUE),
            mediana = median(authoritarianism, na.rm = TRUE),
            desvio_padrao = sd(authoritarianism, na.rm = TRUE),
            minimo = min(authoritarianism, na.rm = TRUE),
            maximo = max(authoritarianism, na.rm = TRUE)) 


