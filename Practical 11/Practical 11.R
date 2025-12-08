
# R Script: Reshaping Data with pivot_longer() and pivot_wider()
# Dataset: loan_approval_dataset.csv

library(dplyr)
library(tidyr)


# 1. SETUP: Import Data


df <- read.csv("loan_approval_dataset.csv", na.strings = c("", "NA"))

# Add a unique ID for tracking during reshaping
df <- df %>% mutate(Applicant_ID = row_number())

cat("\n--- 1. Original Wide Data (First 6 Rows) ---\n")
print(head(df))

# 2. PIVOT_LONGER (Wide to Long)

# Automatically detect numeric columns for reshaping
num_cols <- names(df)[sapply(df, is.numeric)]

# Remove the ID column from pivoting
num_cols <- setdiff(num_cols, "Applicant_ID")

long_df <- df %>%
  pivot_longer(
    cols = all_of(num_cols),
    names_to = "Metric",
    values_to = "Value"
  )

cat("\n--- 2. Long Format (pivot_longer) ---\n")
print(head(long_df, 10))


# 3. PIVOT_WIDER (Long to Wide)

wide_df <- long_df %>%
  pivot_wider(
    names_from = Metric,
    values_from = Value
  )

cat("\n--- 3. Wide Format (pivot_wider - Back to Original) ---\n")
print(head(wide_df))


# 4. ADVANCED EXAMPLE – Category-wise Loan Report

# Choose a category column safely (Gender / Education / Property_Area)
cat_cols <- names(df)[sapply(df, is.character)]

# Pick the first category column automatically
category_col <- cat_cols[1]

cat("\n--- Category used for reporting ---\n")
print(category_col)

category_pivot <- df %>%
  select(Applicant_ID, all_of(category_col), all_of(num_cols[1])) %>%
  pivot_wider(
    names_from = all_of(category_col),
    values_from = all_of(num_cols[1])
  )

cat("\n--- 4. Category-based Pivot Table ---\n")
print(head(category_pivot))
