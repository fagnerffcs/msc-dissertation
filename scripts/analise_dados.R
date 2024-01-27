###########################################
###    EXPLORACAO E ANALISE DE DADOS    ###
###########################################


# BAIXAR PACOTES, CASO ELES AINDA NAO ESTEJAM BAIXADOS
if(!require(dplyr)) install.packages("dplyr")
if(!require(rstatix)) install.packages("rstatix")
if(!require(ggplot2)) install.packages("ggplot2")
if(!require(likert)) install.packages("likert")
if(!require(gridExtra)) install.packages("gridExtra")
if(!require(png)) install.packages("png")
if(!require(viridis)) install.packages("viridis")

# CARREGAR PACOTES
library(dplyr)
library(rstatix)
library(ggplot2)
library(likert)
library(gridExtra)
library(stringr)
library(grid)
library(png)
library(viridis)

setwd("../data")

arch_db <- read.csv2('architectural_decision_survey.csv', sep=",")

arch_db$age <- as.factor(arch_db$age)
arch_db$it_years <- as.factor(arch_db$it_years)
arch_db$job_function <- as.factor(arch_db$job_function)
arch_db$education_level <- as.factor(arch_db$education_level)
arch_db$arch_dec_experience <- as.factor(arch_db$arch_dec_experience)
arch_db$project_phase <- as.factor(arch_db$project_phase)
arch_db$arch_dec_process <- as.factor(arch_db$arch_dec_process)
arch_db$factor_size <- as.factor(arch_db$factor_size)
arch_db$factor_business <- as.factor(arch_db$factor_business)
arch_db$factor_organizational <- as.factor(arch_db$factor_organizational)
arch_db$factor_technical <- as.factor(arch_db$factor_technical)
arch_db$factor_cultural <- as.factor(arch_db$factor_cultural)
arch_db$factor_individual <- as.factor(arch_db$factor_individual)          
arch_db$factor_project <- as.factor(arch_db$factor_project)
arch_db$factor_scope <- as.factor(arch_db$factor_quality_attribute)
arch_db$factor_quality_attribute <- as.factor(arch_db$factor_quality_attribute)
arch_db$factor_user_requirement <- as.factor(arch_db$factor_user_requirement)
arch_db$factor_literature<- as.factor(arch_db$factor_literature)
arch_db$factor_tools_trend_available <- as.factor(arch_db$factor_tools_trend_available)
arch_db$lack_req_clarity <- as.factor(arch_db$lack_req_clarity)
arch_db$non_req_conflict <- as.factor(arch_db$non_req_conflict)
arch_db$insufficient_deadline <- as.factor(arch_db$insufficient_deadline)
arch_db$stakeholder_conflict <- as.factor(arch_db$stakeholder_conflict)
arch_db$contractual_obligation <- as.factor(arch_db$contractual_obligation)
arch_db$business_domain_lack <- as.factor(arch_db$business_domain_lack)
arch_db$principle_facts <- as.factor(arch_db$principle_facts)
arch_db$principle_solution <- as.factor(arch_db$principle_solution)
arch_db$principle_pros_cons <- as.factor(arch_db$principle_pros_cons)
arch_db$principle_solution_limitation <- as.factor(arch_db$principle_solution_limitation)
arch_db$principle_arch_solution <- as.factor(arch_db$principle_arch_solution)
arch_db$principle_timeframe <- as.factor(arch_db$principle_timeframe)
arch_db$principle_priority <- as.factor(arch_db$principle_priority)
arch_db$principle_risks <- as.factor(arch_db$principle_risks)
arch_db$arch_dec_tools <- ifelse(arch_db$arch_dec_tools == "Yes", TRUE, FALSE)

#glimpse(arch_db)
summary(arch_db)

#demographic data tables
table(arch_db$age)
table(arch_db$it_years)
table(arch_db$education_level)
table(arch_db$job_function)
table(arch_db$arch_dec_experience)
table(arch_db$team_size)

#architectural decision tables
table(arch_db$project_phase)
table(arch_db$arch_dec_process)
table(arch_db$arch_dec_confidence)
table(arch_db$arch_dec_tools)

#factor table
table(arch_db$factor_size)
table(arch_db$factor_business)
table(arch_db$factor_organizational)
table(arch_db$factor_technical)
table(arch_db$factor_cultural)
table(arch_db$factor_individual)          
table(arch_db$factor_project)
table(arch_db$factor_quality_attribute)
table(arch_db$factor_quality_attribute)
table(arch_db$factor_user_requirement)
table(arch_db$factor_literature)
table(arch_db$factor_tools_trend_available)

######### TEAM SIZE PLOT #########

ts_plot_colors <- c("#0571b0", "#92c5de", "#abd9e9", "#74add1", "#4575b4")

team_plot <- function(data, filename) {
  # Generate the horizontal bar chart using ggplot2 with light blue fill and theme_minimal
  plot <- ggplot(data, aes(x = team_size, y = after_stat(count))) +
    geom_bar(stat = "count", fill = ts_plot_colors) +
    labs(x = "", y = "Number of Experts") +
    theme_minimal() +
    theme(axis.title.x = element_text(
      size = 16, lineheight = .9,
      family = "Arial", face = "bold.italic"
    )) +
    geom_text(stat = 'count', aes(label = after_stat(count)), vjust = -0.5)
  
  # Print the plot
  print(plot)
  
  # Save the plot to the specified file with smaller dimensions and adjusted DPI
  ggsave(filename, plot, width = 6, height = 4, dpi = 300)
  
  # Print a message indicating the successful saving of the plot
  cat("The plot has been saved as", filename, "\n")
}

team_plot(arch_db, "team_size.png")


######### ARCHITECTURAL DECISION PROCESS PLOT #########

arch_dec_plot_colors <- c("#0571b0", "#abd9e9")

generate_and_save_plot <- function(data, filename) {
  # Generate the horizontal bar chart using ggplot2 with light blue fill and theme_minimal
  plot <- ggplot(data, aes(x = arch_dec_process)) +
    geom_bar(fill = arch_dec_plot_colors) +
    labs(x = "", y = "Number of Experts") +
    theme_minimal() +
    theme(axis.title.x = element_text(
      size = 16, family = "sans"
    )) +    
    geom_text(stat = 'count', aes(label = after_stat(count)), vjust = -0.5)
  
  # Print the plot
  print(plot)
  
  # Save the plot to the specified file with smaller dimensions and adjusted DPI
  ggsave(filename, plot, width = 6, height = 4, dpi = 300)
  
  # Print a message indicating the successful saving of the plot
  cat("The plot has been saved as", filename, "\n")
}

generate_and_save_plot(arch_db, "arch_dec_process.png")


######### PROJECT PHASE PLOT #########

pp_plot_colors <- c("#0571b0", "#92c5de", "#abd9e9", "#74add1")

gns_project_phase <- function(data, filename) {
  # Generate the horizontal bar chart using ggplot2 with light blue fill and theme_minimal
  plot <- ggplot(data, aes(x = project_phase)) +
    geom_bar(fill = pp_plot_colors) +
    labs(x = "", y = "Frequency") +
    theme_minimal() +
    geom_text(stat = 'count', aes(label = after_stat(count)), vjust = -0.5, position = position_dodge2(width = 0.9)) +
    theme(axis.text.x = element_text(angle = 60, vjust = 0.5, hjust=0.5))
  
  # Print the plot
  print(plot)
  
  # Save the plot to the specified file with smaller dimensions and adjusted DPI
  ggsave(filename, plot, width = 8, height = 6, dpi = 300)
  
  # Print a message indicating the successful saving of the plot
  cat("The plot has been saved as", filename, "\n")
}

gns_project_phase(arch_db, "project_phase.png")


################# ARCH DECISION TOOL GRAPH ###############

# Trim whitespace and split values in "arc_dec_doc" field
split_tools <- str_split(trimws(arch_db$arch_dec_doc), pattern = ";")

# Remove empty elements from the split list
split_tools <- split_tools[sapply(split_tools, length) > 0]

# Convert split values to long format
df_long <- data.frame(arc_dec_doc = rep(arch_db$arch_dec_doc, lengths(split_tools)),
                      tool = unlist(split_tools),
                      stringsAsFactors = FALSE)

# Create a summary table of the tools
summary_table <- table(df_long$tool)

# Convert the summary table to a data frame
df_summary <- as.data.frame(summary_table)
colnames(df_summary)[1] <- "tool"
df_summary$tool <- as.character(df_summary$tool)

# Aggregate values with Freq=1 as "Other"
other_count <- sum(df_summary$Freq[df_summary$Freq == 1])
df_summary <- rbind(df_summary[df_summary$Freq > 1, ], data.frame(tool = "Other", Freq = other_count))

# Sort the dataframe by frequency in descending order
df_summary <- df_summary[order(-df_summary$Freq), ]

df_summary$tool[df_summary$tool == "Documento de Texto (Word, Text, Google Docs)"] <- "Text Documents"
df_summary$tool[df_summary$tool == "Código-fonte (Gitlab, Github, DCVS, CVS, etc.)"] <- "Code"
df_summary$tool[df_summary$tool == "Sistema de Gerenciamento de Problemas (Redmine, JIRA, Backlog, etc.)"] <- "Issue Management system"
df_summary$tool[df_summary$tool == "Any/Architectural Decision Record (ADR)"] <- "ADR"


blue_colors <- c("#0571b0", "#92c5de", "#abd9e9", "#74add1", "#4575b4", "#313695", "#6b6ecf")

arch_tool_plot <- ggplot(df_summary, aes(x = tool, y = Freq, fill = tool)) +
  geom_bar(stat = "identity") +
  ylab("Number of experts") +
  theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
  scale_fill_manual(values = blue_colors) +
  geom_text(aes(label = Freq), vjust = -0.5, position = position_dodge(width = 0.9)) +
  labs(x = NULL)

arch_tool_plot

############### INFLUENCE FACTORS: FACTOR SIZE PLOT ################

field_names <- c("Not Important", "Slightly Important", "Moderately Important", "Important", "Very Important", "Not Applicable")
values <- c(2, 6, 7, 11, 6, 1)
data <- data.frame(Value = values, Field = field_names)

# Convert "Field" to a factor with desired levels
data$Field <- factor(data$Field, levels = field_names)

plot1 <- ggplot(data) +
  geom_col(aes(x = Field, y = Value), fill = "#0c8dd2", width = 0.6) +
  ylab("Number of experts") +
  theme_minimal() +
  labs(x = NULL) +
  geom_text(aes(x = Field, y = Value, label = Value), vjust = -0.5, position = position_dodge(width = 0.9))

print(plot1)


ggsave("factor_size.png", plot, width = 8, height = 4, dpi = 300)

table(arch_db$factor_size)
table(arch_db$factor_business)
table(arch_db$factor_user_requirement)
table(arch_db$factor_literature)
table(arch_db$factor_tools_trend_available)


############### INFLUENCE FACTORS: ALL COMBINED ################
# Company Size dataset
field_names <- c("Not Applicable", "Not Important", "Slightly Important", "Moderately Important", "Important", "Very Important")
values_f1 <- c(1, 2, 6, 7, 11, 6)
factor_f1 <- rep("Company Size", length(values_f1))
dataSize <- data.frame(Value = values_f1, Field = field_names, Factor = factor_f1)

# Business dataset
values_f2 <- c(1, 0, 0, 2, 9, 21)
factor_f2 <- rep("Business", length(values_f2))
dataBusiness <- data.frame(Value = values_f2, Field = field_names, Factor = factor_f2)

# Organizational dataset
values_f3 <- c(0, 0, 1, 7, 12, 13)
factor_f3 <- rep("Organizational", length(values_f3))
dataOrg <- data.frame(Value = values_f3, Field = field_names, Factor = factor_f3)

# Technical dataset
values_f4 <- c(0, 0, 1, 3, 9, 20)
factor_f4 <- rep("Technical", length(values_f4))
dataTech <- data.frame(Value = values_f4, Field = field_names, Factor = factor_f4)

# Cultural dataset
values_f5 <- c(1, 2, 8, 5, 9, 8)
factor_f5 <- rep("Cultural", length(values_f5))
dataCultural <- data.frame(Value = values_f5, Field = field_names, Factor = factor_f5)

# Individual dataset
values_f6 <- c(1, 4, 6, 13, 7, 2)
factor_f6 <- rep("Individual", length(values_f6))
dataIndividual <- data.frame(Value = values_f6, Field = field_names, Factor = factor_f6)

# Project dataset
values_f7 <- c(0, 0, 1, 3, 18, 11)
factor_f7 <- rep("Project", length(values_f7))
dataProject <- data.frame(Value = values_f7, Field = field_names, Factor = factor_f7)

# Scope dataset
values_f8 <- c(2, 0, 0, 4, 14, 13)
factor_f8 <- rep("Decision Scope", length(values_f8))
dataScope <- data.frame(Value = values_f8, Field = field_names, Factor = factor_f8)

# QA dataset
values_f9 <- c(2, 0, 0, 4, 14, 13)
factor_f9 <- rep("Quality Attributes", length(values_f9))
dataQA <- data.frame(Value = values_f9, Field = field_names, Factor = factor_f9)

# User requirements dataset
values_f10 <- c(1, 0, 1, 4, 13, 14)
factor_f10 <- rep("User Requirements", length(values_f10))
dataUserReq <- data.frame(Value = values_f10, Field = field_names, Factor = factor_f10)

# Existing Literature dataset
values_f11 <- c(1, 1, 3, 14, 12, 2)
factor_f11 <- rep("Existing Literature", length(values_f11))
dataLiterature <- data.frame(Value = values_f11, Field = field_names, Factor = factor_f11)

# Tools and Technology dataset
values_f12 <- c(0, 0, 2, 5, 11, 15)
factor_f12 <- rep("Tools and Technology Available", length(values_f12))
dataToolsTrends <- data.frame(Value = values_f12, Field = field_names, Factor = factor_f12)

combinedData <- rbind(dataSize, dataBusiness, dataOrg, dataTech, dataCultural, 
                      dataIndividual, dataProject, dataScope, dataQA, dataUserReq, 
                      dataLiterature, dataToolsTrends)

# Define the desired order of importance
order_of_importance <- c("Company Size", "Business", "Organizational", "Technical", "Cultural", "Individual",
                         "Project", "Decision Scope", "Quality Attributes", "User Requirements",
                         "Existing Literature", "Tools and Technology Available")

# Update factor levels in the combinedData dataframe
combinedData$Field <- factor(combinedData$Field, levels = rev(field_names))

# Define the custom color scheme
color_scheme <- rev(c("Not Applicable" = "#6F7BD9",
                  "Not Important" = "#3CB44B",
                  "Slightly Important" = "#FFC700",
                  "Moderately Important" = "#FF5733",
                  "Important" = "#C70039",
                  "Very Important" = "#900C3F"))


plot <- ggplot(combinedData, aes(x = Factor, y = Value, fill = Field)) +
  geom_col(position = "stack", width = 0.6) +
  ylab("Number of experts") +
  xlab("") +
  scale_fill_manual(values = color_scheme, breaks = field_names) +
  theme_bw() +
  coord_flip() +
  labs(fill = "")

plot

ggsave("influence_factors.png", plot, width = 8, height = 4, dpi = 800)

############### CHALLENGES IN DM ################

table(arch_db$lack_req_clarity)

# challenges dataset
impact_scale <- c("Not Applicable", "Very Low", "Below Average", "Average", "Above Average", "Very High")
values_clarity <- c(0, 0, 0, 1, 8, 24)
factor_clarity <- rep("Lack of Clarity", length(values_clarity))
dataClarity <- data.frame(Value = values_clarity, Field = impact_scale, Factor = factor_clarity)

table(arch_db$non_req_conflict)
values_nfr <- c(0, 0, 1, 6, 9, 17)
factor_nfr <- rep("Conflicting NFR", length(values_nfr))
dataNFR <- data.frame(Value = values_nfr, Field = impact_scale, Factor = factor_nfr)

table(arch_db$insufficient_deadline)
values_deadline <- c(0, 0, 1, 3, 7, 22)
factor_deadline <- rep("Insuffient Deadline", length(values_deadline))
dataDeadline <- data.frame(Value = values_deadline, Field = impact_scale, Factor = factor_deadline)

table(arch_db$stakeholder_conflict)
values_stakeholder <- c(0, 0, 7, 6, 7, 13)
factor_stakeholder <- rep("Stakeholder Conflict", length(values_stakeholder))
dataStakeholder <- data.frame(Value = values_stakeholder, Field = impact_scale, Factor = factor_stakeholder)

table(arch_db$contractual_obligation)
values_contractual <- c(0, 1, 6, 8, 7, 11)
factor_contractual <- rep("Legal Contractual Obligation", length(values_contractual))
dataContractual <- data.frame(Value = values_contractual, Field = impact_scale, Factor = factor_contractual)

table(arch_db$business_domain_lack)
values_business <- c(0, 0, 4, 4, 7, 18)
factor_business <- rep("Lack of Business Domain", length(values_business))
dataBusiness <- data.frame(Value = values_business, Field = impact_scale, Factor = factor_business)
                           
combinedDataHard <- rbind(dataClarity, dataNFR, dataDeadline, dataStakeholder, dataContractual, 
                      dataBusiness)

# Define the desired order of importance
order_of_importance_hard <- c("Lack of Clarity", "Conflicting NFR", "Insuffient Deadline", 
                              "Stakeholder Conflict", "Legal Contractual Obligation", 
                              "Lack of Business Domain")

# Update factor levels in the combinedData dataframe
combinedDataHard$Field <- factor(combinedDataHard$Field, levels = rev(impact_scale))

# Define the custom color scheme
color_scheme_hard <- c("Not Applicable" = "#6F7BD9",
                       "Very Low" = "#3CB44B",
                       "Below Average" = "#FFC700",
                       "Average" = "#FF5733",
                       "Above Average" = "#C70039",
                       "Very High" = "#900C3F")

plotHard <- ggplot(combinedDataHard, aes(x = Factor, y = Value, fill = Field)) +
  geom_col(position = "stack", width = 0.6) +
  ylab("Number of experts") +
  xlab("") +
  scale_fill_manual(
    values = color_scheme_hard,
    breaks = impact_scale
  ) +
  theme_bw() +
  coord_flip() +
  labs(fill = "")

plotHard

ggsave("challenges.png", plotHard, width = 8, height = 4, dpi = 800)


############### DM PRINCIPLES ################

table(arch_db$principle_facts)
principle_scale <- c("Not Applicable", "Not Important", "Slightly Important", "Moderately Important", "Important", "Very Important")
values_p1 <- c(0, 0, 0, 1, 10, 22)
factor_p1 <- rep("P1", length(values_p1))
dataP1 <- data.frame(Value = values_p1, Field = principle_scale, Factor = factor_p1)

table(arch_db$principle_solution)
values_p2 <- c(0, 0, 0, 0, 10, 23)
factor_p2 <- rep("P2", length(values_p2))
dataP2 <- data.frame(Value = values_p2, Field = principle_scale, Factor = factor_p2)

table(arch_db$principle_pros_cons)
values_p3 <- c(0, 0, 0, 2, 11, 20)
factor_p3 <- rep("P3", length(values_p3))
dataP3 <- data.frame(Value = values_p3, Field = principle_scale, Factor = factor_p3)

table(arch_db$principle_solution_limitation)
values_p4 <- c(0, 0, 0, 7, 11, 15)
factor_p4 <- rep("P4", length(values_p4))
dataP4 <- data.frame(Value = values_p4, Field = principle_scale, Factor = factor_p4)

table(arch_db$principle_arch_solution)
values_p5 <- c(0, 0, 0, 5, 10, 18)
factor_p5 <- rep("P5", length(values_p5))
dataP5 <- data.frame(Value = values_p5, Field = principle_scale, Factor = factor_p5)

table(arch_db$principle_timeframe)
values_p6 <- c(0, 0, 0, 1, 10, 22)
factor_p6 <- rep("P6", length(values_p6))
dataP6 <- data.frame(Value = values_p6, Field = principle_scale, Factor = factor_p6)

table(arch_db$principle_priority)
values_p7 <- c(0, 0, 0, 2, 14, 17)
factor_p7 <- rep("P7", length(values_p7))
dataP7 <- data.frame(Value = values_p7, Field = principle_scale, Factor = factor_p7)

table(arch_db$principle_risks)
values_p8 <- c(0, 1, 0, 5, 9, 18)
factor_p8 <- rep("P8", length(values_p8))
dataP8 <- data.frame(Value = values_p8, Field = principle_scale, Factor = factor_p8)

combinedDataPrinciples <- rbind(dataP1, dataP2, dataP3, dataP4, dataP5, dataP6,
                                dataP7, dataP8)

# Define the desired order of importance
order_of_importance_principles <- c("P1", "P2", "P3", 
                              "P4", "P5", "P6", "P7", "P8")

# Define the custom color scheme with reversed order
color_scheme_principles <- rev(color_scheme_principles)

# Update factor levels in the combinedDataPrinciples dataframe
combinedDataPrinciples$Field <- factor(combinedDataPrinciples$Field, levels = rev(principle_scale))

plotPrinciple <- ggplot(combinedDataPrinciples, aes(x = Factor, y = Value, fill = Field)) +
  geom_col(position = "stack", width = 0.6) +
  ylab("Number of experts") +
  xlab("") +
  scale_fill_manual(values = color_scheme_principles, breaks = principle_scale) +
  theme_bw() +
  coord_flip() +
  labs(fill = "")

plotPrinciple

ggsave("principles.png", plotPrinciple, width = 8, height = 4, dpi = 800)
