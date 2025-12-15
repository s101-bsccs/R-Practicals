# Module 2 : Practical 1 to 6
# Dataset : Indian_Climate_Dataset_2024_2025.csv
# 
library(dplyr)
library(psych)

# 0. LOAD DATA
df <- read.csv("Indian_Climate_Dataset_2024_2025.csv",
               na.strings = c("", "NA"),
               stringsAsFactors = FALSE)

# Identify numeric and categorical columns safely
num_cols <- names(df)[sapply(df, is.numeric)]
cat_cols <- names(df)[sapply(df, is.character)]

# Choose primary temperature column (first numeric column)
temp_col <- num_cols[1]

# Create grouping variable
df$Temp_Group <- ifelse(df[[temp_col]] > mean(df[[temp_col]], na.rm = TRUE),
                        "High", "Low")

# 1. Practical: Descriptive statistics
print("--- 1. Descriptive Statistics ---")
summary(df[[temp_col]])
describe(df[[temp_col]])

# 2. Practical: Frequency tables
print("--- 2. Frequency Table ---")
freq_col <- cat_cols[1]
table(df[[freq_col]])
df %>% count(.data[[freq_col]])

# 3. Practical: Cross-tabulation
print("--- 3. Cross Tabulation ---")
if (length(cat_cols) >= 2) {
  table(df[[cat_cols[1]]], df[[cat_cols[2]]])
} else {
  print("Not enough categorical columns for cross-tabulation")
}

# 4. Practical: One-sample t-test
print("--- 4. One-Sample t-test ---")

t_test_one <- t.test(df[[temp_col]], mu = mean(df[[temp_col]], na.rm = TRUE))
print(t_test_one)

# 5. Practical: Independent two-sample t-test
print("--- 5. Independent Two-Sample t-test ---")

t_test_two <- t.test(df[[temp_col]] ~ df$Temp_Group)
print(t_test_two)

# 6. Practical: Paired t-test
print("--- 6. Paired t-test ---")

# Use first two numeric columns for paired test
if (length(num_cols) >= 2) {
  t_test_paired <- t.test(df[[num_cols[1]]],
                          df[[num_cols[2]]],
                          paired = TRUE)
  print(t_test_paired)
} else {
  print("Not enough numeric columns for paired t-test")
}
