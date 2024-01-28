# Set the working directory
setwd("../data")

# Load necessary libraries
library(ggplot2)
library(dplyr)

#RENOMEANDO DAS COLUNAS
cols_renamed <- c(dt_hora = "Carimbo.de.data.hora", 
                  age="Qual.a.sua.idade.",
                  company_type = "Qual.o.tipo.da.empresa.que.você.trabalha.",
                  company_size = "Qual.o.tamanho.da.sua.empresa.",
                  company_nature = "Qual.a.natureza.da.sua.empresa.",
                  solution_type = "Qual.o.tipo.da.solução.que.sua.empresa.trabalha.",
                  agreement = "Confirme.que.você.concorda.com.os.termos.e.condições.acima.para.a.pesquisa.",
                  q1_farol = "O.framework.de.decisão.arquitetural..FAROL..auxiliou.no.processo.de.tomada.de.decisão.",
                  q2_farol = "Decisões.arquiteturais.significativas..aquelas.que.tem.potencial.de.inviabilizar.o.projeto.ou.torná.lo.oneroso.demais..foram.observadas.durante.a.análise.arquitetural.",
                  q3_farol = "Vários.aspectos.relevantes.distintos.para.tomada.de.decisão.arquitetural.foram.explorados.pelo.FAROL..",
                  q4_farol = "Esse.exemplo.de.utilização.do.FAROL.não.provê.elementos.suficientes.para.uma.boa.análise.arquitetural.",
                  farol_shortcomings = "Considerando.o.que.foi.apresentado.e.a.estrutura.do.FAROL..quais.as.dificuldades.que.você.identificou.no.framework.",
                  farol_improvements = "Quais.pontos.você.considera.passível.de.melhoria.para.o.framework."
)

# Read the CSV file
data <- read.csv("Tomada de Decisão Arquitetural Revisada.csv")

data <- rename(data, all_of(cols_renamed))

View(data)

############### Q1, Q2, Q3, Q4: ALL COMBINED ################

field_names <- c("Strongly Disagree", "Disagree", "Neither Agree or disagree", "Agree", "Strongly Agree")
values_q1 <- c(0, 0, 1, 7, 4)
factor_q1 <- rep("Q1", length(values_q1))
dataQ1 <- data.frame(Value = values_q1, Field = field_names, Factor = factor_q1)

values_q2 <- c(0, 1, 2, 6, 3)
factor_q2 <- rep("Q2", length(values_q2))
dataQ2 <- data.frame(Value = values_q2, Field = field_names, Factor = factor_q2)

values_q3 <- c(0, 0, 2, 3, 7)
factor_q3 <- rep("Q3", length(values_q3))
dataQ3 <- data.frame(Value = values_q3, Field = field_names, Factor = factor_q3)

values_q4 <- c(3, 6, 1, 2, 0)
factor_q4 <- rep("Q4", length(values_q4))
dataQ4 <- data.frame(Value = values_q4, Field = field_names, Factor = factor_q4)

combinedData <- rbind(dataQ1, dataQ2, dataQ3, dataQ4)

# Ensure 'Field' is a factor and its levels are ordered as per 'field_names'
combinedData$Field <- factor(combinedData$Field, levels = field_names)

# Define the color scheme
color_scheme <- c("Strongly Disagree" = "#A7270C",
                  "Disagree" = "#E4340F",
                  "Neither Agree or disagree" = "#F9F62D",
                  "Agree" = "#0571b0",
                  "Strongly Agree" = "#6F7BD9")

# Create the plot
plot <- ggplot(combinedData, aes(x = Factor, y = Value, fill = Field)) +
  geom_col(position = "stack", width = 0.6) +
  ylab("Number of experts") +
  xlab("") +
  scale_fill_manual(values = color_scheme) +
  theme_bw() +
  coord_flip() +
  labs(fill = "")

# Display the plot
plot

# Save the plot
ggsave("farol_survey_eval.png", plot, width = 8, height = 4, dpi = 800)
