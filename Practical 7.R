# Robust and safe version of your select/drop code for features.csv
library(dplyr)

# 0. Load dataset (adjust path if needed)
features <- read.csv("features.csv", stringsAsFactors = FALSE)

# 0.1 Show first 3 rows so we can confirm the file loaded
cat("--- First 3 rows of the dataset ---\n")
print(head(features, 3))
cat("\n--- Column names ---\n")
print(names(features))

# Helper: assert that columns exist (prints warning instead of crashing)
check_cols <- function(cols, df) {
  missing <- setdiff(cols, names(df))
  if (length(missing) > 0) {
    warning("The following columns are missing from the dataset: ", paste(missing, collapse = ", "))
    return(FALSE)
  }
  return(TRUE)
}

# ------------------------------------------------------
# 1. SELECT SPECIFIC COLUMNS (safe)
# ------------------------------------------------------
cols_keep <- c("Store", "Date", "Temperature")
if (check_cols(cols_keep, features)) {
  selected_cols <- features %>% select(all_of(cols_keep))
  cat("\n--- Selected specific columns (first 3 rows) ---\n")
  print(head(selected_cols, 3))
} else {
  cat("\nSkipping select(all_of(cols_keep)) because some columns are missing.\n")
}

# ------------------------------------------------------
# 2. SELECT A RANGE OF COLUMNS (explicit, safe)
# ------------------------------------------------------
# Instead of relying on position-based range, build the list explicitly:
range_start <- "Temperature"
range_end   <- "MarkDown3"

if (all(c(range_start, range_end) %in% names(features))) {
  # create vector of column names between start and end (inclusive)
  start_i <- which(names(features) == range_start)
  end_i   <- which(names(features) == range_end)
  if (start_i <= end_i) {
    cols_range <- names(features)[start_i:end_i]
    range_cols <- features %>% select(all_of(cols_range))
    cat("\n--- Selected range (Temperature to MarkDown3) first 3 rows ---\n")
    print(head(range_cols, 3))
  } else {
    warning("Range start appears after range end in the dataset column order.")
  }
} else {
  warning("Cannot select range: one or both boundary columns not found.")
}

# ------------------------------------------------------
# 3. SELECT USING HELPER FUNCTIONS (starts_with)
# ------------------------------------------------------
markdown_cols <- features %>% select(starts_with("MarkDown"))
cat("\n--- Columns starting with 'MarkDown' (first 3 rows) ---\n")
print(head(markdown_cols, 3))

# ------------------------------------------------------
# 4. DROP ONE COLUMN (safe)
# ------------------------------------------------------
col_to_drop <- "IsHoliday"
if (col_to_drop %in% names(features)) {
  dropped_one <- features %>% select(-all_of(col_to_drop))
  cat("\n--- Dropped column 'IsHoliday' ---\n")
  print(names(dropped_one))
} else {
  warning(paste("Column to drop not found:", col_to_drop))
}

# ------------------------------------------------------
# 5. DROP MULTIPLE COLUMNS (safe)
# ------------------------------------------------------
cols_to_drop <- c("MarkDown1", "MarkDown2")
existing_to_drop <- intersect(cols_to_drop, names(features))
if (length(existing_to_drop) > 0) {
  dropped_multiple <- features %>% select(-all_of(existing_to_drop))
  cat("\n--- Dropped MarkDown1 and/or MarkDown2 (remaining names) ---\n")
  print(names(dropped_multiple))
} else {
  warning("None of MarkDown1 or MarkDown2 exist in the dataset.")
}

# ------------------------------------------------------
# 6. DROP A RANGE (explicit)
# ------------------------------------------------------
# Remove MarkDown3 to MarkDown5 (explicitly build vector)
rm_start <- "MarkDown3"
rm_end   <- "MarkDown5"
if (all(c(rm_start, rm_end) %in% names(features))) {
  start_i <- which(names(features) == rm_start)
  end_i   <- which(names(features) == rm_end)
  if (start_i <= end_i) {
    cols_to_remove_range <- names(features)[start_i:end_i]
    dropped_range <- features %>% select(-all_of(cols_to_remove_range))
    cat("\n--- Removed columns MarkDown3..MarkDown5 (remaining names) ---\n")
    print(names(dropped_range))
  } else {
    warning("MarkDown3 appears after MarkDown5 in column order; can't remove range by positions.")
  }
} else {
  warning("Cannot remove MarkDown3..MarkDown5 — one or more columns are missing.")
}
