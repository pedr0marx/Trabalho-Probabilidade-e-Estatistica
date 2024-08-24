  require(summarytools)
  require(fdth)
  require(ggplot2)
  require(readxl)
  require(readr)
  require(dplyr)
  
  
  # Carregar os pacotes necessários
  library(readxl)
  library(dplyr)
  library(ggplot2)
  
  data_summary <- data %>%
    group_by(ANO_IS, OBITO) %>%
    summarise(Count = n()) %>%
    ungroup()
  
  # Criar o gráfico
  ggplot(data_summary, aes(x = as.factor(ANO_IS), y = Count, fill = OBITO)) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(title = "Infecções por Ano e Óbitos",
         x = "Ano",
         y = "Número de Infecções",
         fill = "Óbito") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
