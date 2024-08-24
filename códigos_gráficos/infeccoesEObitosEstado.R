# Carregar os pacotes necessários
library(readxl)
library(dplyr)
library(ggplot2)

# Supondo que você já tenha carregado os dados no dataframe 'data'
data_summary <- data %>%
  group_by(UF_LPI, OBITO) %>%  # Agrupar por estado e óbito
  summarise(Count = n()) %>%   # Contar o número de registros
  ungroup()

# Criar o gráfico
ggplot(data_summary, aes(x = as.factor(UF_LPI), y = Count, fill = OBITO)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Infecções por Estado e Óbitos",
       x = "Estado",
       y = "Número de Infecções",
       fill = "Óbito") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Ajuste o ângulo dos rótulos se necessário
