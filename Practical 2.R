# Install packages (run once)
install.packages(c("readxl", "psych"))

# Load libraries
library(readxl)
library(psych)

# Check your working directory
getwd()

# If the file is NOT in your working directory, set it manually:
# Example:
# setwd("C:/Users/YourFolder/Desktop")

# Load the dataset
my_data <- read_excel("insurance.xlsx")

# Confirm that the data loaded
print(my_data)

# First few rows
head(my_data)

# Last few rows
tail(my_data)

# Dimensions
cat("Dimensions (Rows, Columns):", dim(my_data), "\n")

# Structure
str(my_data)

# Summary
summary(my_data)

# Column names
cat("Column Names:", names(my_data), "\n")

# Detailed statistics
describe(my_data)

