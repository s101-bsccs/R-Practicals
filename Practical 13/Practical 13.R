# R Script: Identifying and Handling Duplicates
# Function: distinct() from the dplyr package
# Dataset: Student Records

# Load the library
library(dplyr)

# 1. SETUP: Create a Dataset with Intentional Duplicates
students_df <- data.frame(
  RollNo = c("S101", "S102", "S102", "S103", "S104", "S101", "S104"),
  Student = c("RAJDEEP", "Vinod", "Bharghav", "Karan", "Rohit", "Amit", "Rohan"),
  Subject = c("Maths", "Physics", "Physics", "Chemistry", "Biology", "Maths", "Computer")
)
print("--- 1. Original Dataset (Note 7 rows) ---")
print(students_df)

# 2. IDENTIFYING DUPLICATES (Before removing them)
# Using group_by() and count() to find duplicate rows
duplicates_report <- students_df %>%
  group_by(RollNo, Student, Subject) %>%
  count() %>%          # Counts occurrences
  filter(n > 1)        # Keeps only rows that appear more than once
print("--- 2. Identification Report (Rows that are duplicated) ---")
print(duplicates_report)

# 3. HANDLING DUPLICATES: Exact Matches
# Scenario: Remove rows where EVERY column is identical.
clean_exact <- students_df %>%
  distinct()
print("--- 3. Removed Exact Duplicates (distinct) ---")
print(clean_exact)


# 4. HANDLING DUPLICATES: Specific Columns (.keep_all = TRUE)
# Scenario: We want a list of UNIQUE STUDENTS.
unique_students <- students_df %>%
  distinct(Student, .keep_all = TRUE)
print("--- 4. Unique Students Only (Partial Duplicates removed) ---")
print(unique_students)
