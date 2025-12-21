# S101 RAJDEEPP .M. PARAB
# PRACTICAL 7: ONE-WAY ANOVA
# Dataset: diabetes.csv
# Load the dataset
diabetes_risk <- read.csv("diabetes_risk_dataset.csv")
# Check structure to confirm column names
str(diabetes_risk)
# Convert physical_activity_level to factor
diabetes_risk$physical_activity_level <- as.factor(
  diabetes_risk$physical_activity_level
)
# Perform one-way ANOVA
anova_one_way <- aov(glucose_level ~ physical_activity_level,
                     data = diabetes_risk)
# Display ANOVA table
summary(anova_one_way)
# HYPOTHESIS DECISION
p_value <- summary(anova_one_way)[[1]][["Pr(>F)"]][1]
if (p_value < 0.05) {
  cat("Result: Reject the Null Hypothesis\n")
  cat("Reason: Glucose levels significantly differ based on physical activity level.\n")
} else {
  cat("Result: Accept the Null Hypothesis\n")
  cat("Reason: No significant difference in glucose levels across activity levels.\n")
}
