library(readxl)
library(dplyr)
library(ggplot2)

# Calcular o total de infecções por estado
data_summary <- data %>%
  group_by(UF_LPI) %>%  # Agrupar por estado
  summarise(Count = n()) %>%   # Contar o número de infecções por estado
  ungroup()

# Calcular o total geral de infecções
total_infecoes <- sum(data_summary$Count)

# Calcular a porcentagem de infecções por estado
data_summary <- data_summary %>%
  mutate(Percent = (Count / total_infecoes) * 100)  # Calcular a porcentagem

# Criar o gráfico
ggplot(data_summary, aes(x = reorder(UF_LPI, -Percent), y = Percent, fill = UF_LPI)) +
  geom_bar(stat = "identity") +
  labs(title = "Percentual de Infecções por Estado",
       x = "Estado",
       y = "Percentual (%)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
