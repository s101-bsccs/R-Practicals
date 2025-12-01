
# PRACTICAL: Handling Missing Values using na.omit() & replace_na()
# Dataset: high_popularity_spotify_data.csv

library(dplyr)
library(tidyr)

# 1. IMPORT DATASET
spotify <- read.csv("high_popularity_spotify_data.csv",
                    na.strings = c("", "NA"))

cat("\n--- Original Data (First 6 Rows) ---\n")
print(head(spotify))

cat("\n--- Missing Values Per Column ---\n")
print(colSums(is.na(spotify)))

# ==========================================================
# 2. METHOD A: REMOVE ALL ROWS WITH ANY NA (na.omit)
# ==========================================================

clean_omit <- na.omit(spotify)

cat("\n--- Data After na.omit() ---\n")
cat("Original rows:", nrow(spotify), "\n")
cat("Rows remaining:", nrow(clean_omit), "\n")
print(head(clean_omit))

# ==========================================================
# 3. METHOD B: REPLACE MISSING VALUES
# ==========================================================

# Detect numeric and character columns automatically
num_cols <- names(spotify)[sapply(spotify, is.numeric)]
char_cols <- names(spotify)[sapply(spotify, is.character)]

cat("\n--- Numeric Columns Detected ---\n")
print(num_cols)

cat("\n--- Character Columns Detected ---\n")
print(char_cols)

# Create replacements
# Numeric missing values → column mean
mean_values <- spotify %>%
  summarise(across(all_of(num_cols), ~ mean(.x, na.rm = TRUE)))

# Character missing values → "Unknown"
char_replacements <- as.list(rep("Unknown", length(char_cols)))
names(char_replacements) <- char_cols

# Apply replacements
clean_replace <- spotify %>%
  replace_na(char_replacements) %>%
  mutate(across(
    all_of(num_cols),
    ~ replace(.x, is.na(.x), mean_values[[cur_column()]])
  ))

cat("\n--- Data After replace_na() ---\n")
print(head(clean_replace, 3))

cat("\n--- Remaining Missing Values After Cleaning ---\n")
print(colSums(is.na(clean_replace)))
