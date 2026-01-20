# S101 RAJDEEP M PARAB
# PRACTICAL 13 – Linear Regression using lm()
# Dataset: Indian_Climate_Dataset_2024_2025.csv

# Load required libraries
library(ggplot2)
library(dplyr)

# 1. Load dataset
df <- read.csv("Indian_Climate_Dataset_2024_2025.csv")

# 2. Identify numeric columns automatically
num_cols <- names(df)[sapply(df, is.numeric)]

# Use first numeric column as dependent variable (Y)
# Use second numeric column as independent variable (X)
dep_var <- num_cols[1]
ind_var <- num_cols[2]

cat("Dependent Variable:", dep_var, "\n")
cat("Independent Variable:", ind_var, "\n")

# 3. Prepare data for regression
df_lr <- df %>%
  select(all_of(c(dep_var, ind_var))) %>%
  na.omit()

# 4. Use only first 20 rows for neat graph
df_lr <- df_lr[1:20, ]

# 5. Fit Linear Regression Model
formula_used <- as.formula(paste(dep_var, "~", ind_var))
model <- lm(formula_used, data = df_lr)

# Display model summary
summary(model)

# 6. Scatter Plot with Regression Line (Clean Output)
ggplot(df_lr, aes(x = .data[[ind_var]], y = .data[[dep_var]])) +
  geom_point(color = "blue", size = 3) +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(
    title = "Linear Regression Analysis",
    x = ind_var,
    y = dep_var
  ) +
  theme_minimal()


