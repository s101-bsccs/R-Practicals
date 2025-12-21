# S101 RAJDEEPP .M. PARAB
# PRACTICAL 8: TWO-WAY ANOVA
# Dataset : diabetes.csv
# Load the dataset
diabetes <- read.csv("diabetes.csv")
# View structure of dataset
str(diabetes)
# Create age groups
diabetes$age_group <- cut(diabetes$age,
                          breaks = c(0, 40, 60, 100),
                          labels = c("Young", "Middle", "Old"))
# Convert gender to factor
diabetes$gender <- as.factor(diabetes$gender)
# Perform two-way ANOVA
anova_two_way <- aov(glucose ~ gender * age_group,
                     data = diabetes)
# Display ANOVA table
summary(anova_two_way)
# HYPOTHESIS DECISION
p_values <- summary(anova_two_way)[[1]][["Pr(>F)"]]
if (any(p_values < 0.05, na.rm = TRUE)) {
  cat("Result: Reject the Null Hypothesis\n")
  cat("Reason: Gender, age group, or their interaction significantly affects glucose levels.\n")
} else {
  cat("Result: Accept the Null Hypothesis\n")
  cat("Reason: No significant effect of gender or age group on glucose levels.\n")
}

