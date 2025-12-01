# PRACTICAL 10 – Creating New Variables using Transformations & Calculations
# Dataset: cards_data.csv

library(dplyr)
library(tidyr)

# 1. IMPORT DATASET
df <- read.csv("cards_data.csv", na.strings = c("", "NA"), stringsAsFactors = FALSE)
cat("\n--- Original Dataset (First 6 Rows) ---\n")
print(head(df))

# FIX 1: Convert columns to correct formats
df <- df %>%
  mutate(
    card_number = as.character(card_number),
    expires = as.character(expires),
    credit_limit = as.numeric(credit_limit),
    year_pin_last_changed = as.numeric(year_pin_last_changed),
    card_on_dark_web = as.numeric(card_on_dark_web)
  )

# Replace NA numeric values with 0 to avoid calculation errors
df <- df %>% 
  mutate(across(where(is.numeric), ~ replace_na(.x, 0)))


# 2. METHOD A: ARITHMETIC CALCULATIONS
df_calc <- df %>%
  mutate(
    estimated_annual_fee = credit_limit * 0.02
  )
cat("\n--- Method A: Arithmetic Calculations (Annual Fee) ---\n")
print(df_calc %>% select(credit_limit, estimated_annual_fee) %>% head())


# 3. METHOD B: CONDITIONAL LOGIC
df_logic <- df %>%
  mutate(
    card_value_type = ifelse(credit_limit > 50000, "Premium Card", "Standard Card"),
    risk_flag = ifelse(card_on_dark_web == 1, "HIGH RISK", "SAFE")
  )
cat("\n--- Method B: Conditional Logic Results ---\n")
print(df_logic %>% select(credit_limit, card_value_type, card_on_dark_web, risk_flag) %>% head())


# 4. METHOD C: STRING / TEXT TRANSFORMATION
df_text <- df %>%
  mutate(
    last4 = ifelse(nchar(card_number) >= 4,
                   substr(card_number, nchar(card_number) - 3, nchar(card_number)),
                   NA),
    card_label = paste(card_brand, "-", card_type)
  )
cat("\n--- Method C: Text Transformations ---\n")
print(df_text %>% select(card_number, last4, card_label) %>% head())


# 5. METHOD D: DATE / TIME BASED TRANSFORMATION
df_dates <- df %>%
  mutate(
    card_age = 2025 - year_pin_last_changed,
    expiry_year = paste0("20", substr(expires, 4, 5))
  )
cat("\n--- Method D: Date Transformations ---\n")
print(df_dates %>% select(year_pin_last_changed, card_age, expires, expiry_year) %>% head())


# 6. FINAL COMBINED DATASET
final_df <- df %>%
  mutate(
    estimated_annual_fee = credit_limit * 0.02,
    card_value_type = ifelse(credit_limit > 50000, "Premium Card", "Standard Card"),
    risk_flag = ifelse(card_on_dark_web == 1, "HIGH RISK", "SAFE"),
    last4 = ifelse(nchar(card_number) >= 4,
                   substr(card_number, nchar(card_number) - 3, nchar(card_number)),
                   NA),
    card_label = paste(card_brand, "-", card_type),
    card_age = 2025 - year_pin_last_changed,
    expiry_year = paste0("20", substr(expires, 4, 5))
  )
cat("\n--- FINAL DATASET (First 6 Rows) ---\n")
print(head(final_df))
