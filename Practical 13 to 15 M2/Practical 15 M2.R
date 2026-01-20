
# PRACTICAL 15 – Exporting Results to CSV and Excel
# Dataset : results.csv

# 1. Load required libraries
install.packages("writexl")
library(dplyr)
library(writexl)

# 2. Load dataset
df <- read.csv("results.csv")

# View first few rows
head(df)

# 3. Create a simple processed result (example)
# Adding a new column just to show "result processing"
result_df <- df %>%
  mutate(Status = "Processed")

# 4. Export result to CSV file
write.csv(
  result_df,
  file = "Practical15_Output.csv",
  row.names = FALSE
)

# 5. Export result to Excel file
write_xlsx(
  result_df,
  path = "Practical15_Output.xlsx"
)

# 6. Confirmation message
cat("Files exported successfully:\n")
cat("1. Practical15_Output.csv\n")
cat("2. Practical15_Output.xlsx\n")
