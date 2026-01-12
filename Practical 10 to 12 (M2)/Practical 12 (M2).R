# S101 RAJDEEPP .M. PARAB
# Data Analysis with SAS / SPSS / R Practical
# PRACTICAL 12 – Correlation Matrix in R
# Dataset: water_potability.csv
# Load libraries
library(dplyr)

# 1. Load dataset
df <- read.csv("water_potability.csv")

# 2. Keep only numeric columns
num_df <- df %>% select_if(is.numeric)

# 3. Remove missing values
num_df <- na.omit(num_df)


# 4. Compute correlation matrix
cor_matrix <- cor(num_df)

# Print full matrix
print(cor_matrix)

# Rounded clean matrix view
round(cor_matrix, 2)

# 5. Install and load corrplot (for graph)
install.packages("corrplot")
library(corrplot)



