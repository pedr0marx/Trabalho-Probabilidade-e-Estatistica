# Carregar os pacotes necessários
library(readxl)
library(dplyr)
library(ggplot2)

# Carregar os dados do arquivo Excel (ajuste o caminho e nome do arquivo conforme necessário)
data <- read_excel("C:/Users/Pichau/OneDrive/Área de Trabalho/prob/fa_casoshumanos_1994-2023(1).xlsx")

# Verificar as primeiras linhas dos dados para confirmar que foram carregados corretamente
# Converter a coluna OBITO para valores binários e a coluna IDADE para numérica
data <- data %>%
  mutate(
    OBITO = ifelse(OBITO == "SIM", 1, 0),
    IDADE = as.numeric(IDADE)
  )

# Criar intervalos de idade (faixas etárias)
data <- data %>%
  mutate(Faixa_Etaria = cut(IDADE, breaks = seq(0, 100, by = 10), right = FALSE, 
                            labels = paste(seq(0, 90, by = 10), seq(10, 100, by = 10), sep = "-")))

# Calcular a taxa de mortalidade por faixa etária e sexo
data_taxa_mortalidade <- data %>%
  group_by(Faixa_Etaria, SEXO) %>%  # Agrupar por faixa etária e sexo
  summarise(
    Total_Casos = n(),
    Total_Obitos = sum(OBITO)
  ) %>%
  ungroup() %>%
  mutate(Taxa_Mortalidade = (Total_Obitos / Total_Casos) * 100)  # Calcular a taxa de mortalidade

# Verificar o resumo dos dados transformados
print(data_taxa_mortalidade)

# Criar o gráfico
ggplot(data_taxa_mortalidade, aes(x = Faixa_Etaria, y = Taxa_Mortalidade, color = SEXO, group = SEXO)) +
  geom_line(size = 1) +  # Linha para cada sexo
  geom_point(size = 3) +  # Pontos para destacar os dados
  labs(title = "Taxa de Mortalidade por Faixa Etária e Sexo",
       x = "Faixa Etária",
       y = "Taxa de Mortalidade (%)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
