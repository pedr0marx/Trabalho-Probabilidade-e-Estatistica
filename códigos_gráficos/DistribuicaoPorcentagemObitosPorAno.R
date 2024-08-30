# Carregar os pacotes necessários
library(readxl)
library(dplyr)
library(ggplot2)

# Carregar os dados do arquivo Excel (ajuste o caminho e nome do arquivo conforme necessário)

data <- read_excel("C:/Users/Pichau/OneDrive/Área de Trabalho/prob/fa_casoshumanos_1994-2023(1).xlsx")


# Filtrar e transformar os dados para considerar apenas os óbitos
data_obitos_ano <- data %>%
  mutate(OBITO = ifelse(OBITO == "SIM", 1, 0)) %>%  # Converter óbito para 1 e 0
  group_by(ANO_IS) %>%  # Agrupar por ano
  summarise(
    Total_Casos = n(),
    Total_Obitos = sum(OBITO)
  ) %>%
  ungroup()

# Verificar o resumo dos dados transformados
print(data_obitos_ano)

# Calcular o total geral de óbitos
total_obitos_ano <- sum(data_obitos_ano$Total_Obitos)

# Verificar o total de óbitos
print(total_obitos_ano)

# Calcular a porcentagem de óbitos por ano
data_obitos_ano <- data_obitos_ano %>%
  mutate(Percent_Obitos = (Total_Obitos / total_obitos_ano) * 100)  # Calcular a porcentagem

# Verificar o resultado da porcentagem
print(data_obitos_ano)

# Criar o gráfico
ggplot(data_obitos_ano, aes(x = as.factor(ANO_IS), y = Percent_Obitos, group = 1)) +
  geom_line(color = "blue", size = 1) +  # Linha azul com espessura 1
  geom_point(color = "blue", size = 3) +  # Pontos azuis para destacar os dados
  labs(title = "Distribuição da Percentagem de Óbitos por Ano",
       x = "Ano",
       y = "Percentual (%)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
