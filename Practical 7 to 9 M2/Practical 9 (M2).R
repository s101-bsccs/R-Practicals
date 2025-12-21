# S101 RAJDEEPP .M. PARAB
# PRACTICAL 9: CHI-SQUARE TEST
# Dataset: shopping_behavior_updated.csv
# Load the dataset
shopping <- read.csv("shopping_behavior_updated.csv")
# Create contingency table
table_data <- table(shopping$Category,
                    shopping$Subscription.Status)
# Display contingency table
table_data
# Perform Chi-square test
chi_test <- chisq.test(table_data)
# Display test result
chi_test
# HYPOTHESIS DECISION
if (chi_test$p.value < 0.05) {
  cat("Result: Reject the Null Hypothesis\n")
  cat("Reason: Product category is associated with subscription status.\n")
} else {
  cat("Result: Accept the Null Hypothesis\n")
  cat("Reason: Product category and subscription status are independent.\n")
}

