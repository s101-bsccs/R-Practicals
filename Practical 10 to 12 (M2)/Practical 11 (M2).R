# ==============================
# PRACTICAL 11
# Histograms and Boxplots (clean view)
# ==============================

library(ggplot2)
library(dplyr)

# Load dataset
df <- read.csv("retail_sales_dataset.csv")

# -------------------------------
# 1. choose numeric and categorical columns
# -------------------------------
num_cols <- names(df)[sapply(df, is.numeric)]
cat_cols <- names(df)[sapply(df, is.character) | sapply(df, is.factor)]

num_var <- num_cols[1]      # numeric variable
cat_var <- cat_cols[1]      # categorical variable

cat("\nNumeric used:", num_var)
cat("\nCategorical used:", cat_var, "\n")

# -------------------------------
# 2. take a small clean subset for neat plotting
# -------------------------------
# keep only first 4 groups of category
small_df <- df %>%
  filter(!is.na(.data[[num_var]]), !is.na(.data[[cat_var]])) %>%
  group_by(.data[[cat_var]]) %>%
  slice_head(n = 20) %>%      # 20 observations per group
  ungroup() %>%
  slice_head(n = 80)          # max 80 rows total

cat("\nRows used for boxplot:", nrow(small_df), "\n")

# -------------------------------
# 3. HISTOGRAM (numeric variable)
# -------------------------------
ggplot(small_df, aes(x = .data[[num_var]])) +
  geom_histogram(bins = 20, color = "black", fill = "skyblue") +
  labs(title = paste("Histogram of", num_var),
       x = num_var,
       y = "Frequency")

# -------------------------------
# 4. BOX PLOT (clean & clear like your example)
# -------------------------------
ggplot(small_df, aes(x = .data[[cat_var]], y = .data[[num_var]])) +
  geom_boxplot(fill = "lightblue", color = "black", outlier.color = "red") +
  labs(
    title = paste("Boxplot of", num_var, "by", cat_var),
    x = cat_var,
    y = num_var
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.text.x = element_text(angle = 15)
  )

