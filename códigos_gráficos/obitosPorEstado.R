# Carregar os pacotes necessários
library(readxl)
library(dplyr)
library(ggplot2)

data <- read_excel("C:/Users/Pichau/OneDrive/Área de Trabalho/prob/fa_casoshumanos_1994-2023(1).xlsx")

data_obitos <- data %>%
  mutate(OBITO = ifelse(OBITO == "SIM", 1, 0)) %>%  # Converter óbito para 1 e 0
  group_by(UF_LPI) %>%  # Agrupar por estado
  summarise(
    Total_Casos = n(),
    Total_Obitos = sum(OBITO)
  ) %>%
  ungroup()

# Verificar o resumo dos dados transformados
print(data_obitos)

# Calcular o total geral de óbitos
total_obitos <- sum(data_obitos$Total_Obitos)

# Verificar o total de óbitos
print(total_obitos)

# Calcular a porcentagem de óbitos por estado
data_obitos <- data_obitos %>%
  mutate(Percent_Obitos = (Total_Obitos / total_obitos) * 100)  # Calcular a porcentagem

# Verificar o resultado da porcentagem
print(data_obitos)

# Criar o gráfico
ggplot(data_obitos, aes(x = reorder(UF_LPI, -Percent_Obitos), y = Percent_Obitos, fill = UF_LPI)) +
  geom_bar(stat = "identity") +
  labs(title = "Percentual de Óbitos por Estado",
       x = "Estado",
       y = "Percentual (%)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))