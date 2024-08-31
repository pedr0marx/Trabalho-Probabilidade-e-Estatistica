require(summarytools)
require(fdth)
require(ggplot2)
require(readxl)
require(readr)
require(dplyr)


library(readxl)
library(dplyr)
library(ggplot2)

data_filtered <- data %>%
  filter(MES_IS >= 1 & MES_IS <= 12)

# Contar o número de infecções por mês
data_summary <- data_filtered %>%
  group_by(MES_IS) %>%
  summarise(Quantidade_Infeccao = n()) %>%
  arrange(MES_IS)

# Criar o gráfico
ggplot(data_summary, aes(x = as.factor(MES_IS), y = Quantidade_Infeccao)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Quantidade de Infecções por Mês",
       x = "Mês",
       y = "Quantidade de Infecções") +
  theme_minimal() +
  scale_x_discrete(breaks = 1:12, labels = month.name) +  # Mês como nome do mês
  scale_y_continuous(breaks = seq(0, max(data_summary$Quantidade_Infeccao), by = 200))

