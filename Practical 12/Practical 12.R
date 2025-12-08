# PRACTICAL 12 – Combining datasets vertically using rbind()
library(dplyr)

# 1. IMPORT BOTH DATASETS
usage1 <- read.csv("random_smartphone_usage_dataset.csv",
                   na.strings = c("", "NA"),
                   stringsAsFactors = FALSE)
usage2 <- read.csv("mobile_usage_behavioral_analysis.csv",
                   na.strings = c("", "NA"),
                   stringsAsFactors = FALSE)
cat("\n--- Dataset 1 Columns ---\n")
print(names(usage1))
cat("\n--- Dataset 2 Columns ---\n")
print(names(usage2))

# 2. FIND COMMON COLUMNS SAFELY
common_cols <- intersect(names(usage1), names(usage2))
cat("\n--- Common Columns Detected ---\n")
print(common_cols)
# If NO common columns are found, stop safely
if (length(common_cols) == 0) {
  stop(" ERROR: No common columns found between the two datasets. rbind() cannot be applied.")
}

# 3. ALIGN BOTH DATASETS USING ONLY COMMON COLUMNS
usage1_clean <- usage1[, common_cols, drop = FALSE]
usage2_clean <- usage2[, common_cols, drop = FALSE]

# 4. ENSURE DATA TYPES MATCH (SAFE LOOP)
for (col in common_cols) {
  # If either column is numeric, force both to numeric
  if (is.numeric(usage1_clean[[col]]) || is.numeric(usage2_clean[[col]])) {
    usage1_clean[[col]] <- as.numeric(usage1_clean[[col]])
    usage2_clean[[col]] <- as.numeric(usage2_clean[[col]])
  }
}

# 5. VERTICAL COMBINATION USING rbind()
combined_data <- rbind(usage1_clean, usage2_clean)
cat("\n--- Combined Data Summary ---\n")
print(paste("Dataset 1 Rows:", nrow(usage1_clean)))
print(paste("Dataset 2 Rows:", nrow(usage2_clean)))
print(paste("Total Rows (Expected):", nrow(usage1_clean) + nrow(usage2_clean)))
print(paste("Total Rows (Actual):", nrow(combined_data)))
cat("\n--- Preview of Combined Data (Top 6 Rows) ---\n")
print(head(combined_data))
cat("\n--- Preview of Combined Data (Bottom 6 Rows) ---\n")
print(tail(combined_data))

