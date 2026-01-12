# PRACTICAL 10 – Graphical Reports using ggplot2

library(ggplot2)
library(dplyr)

# Load dataset
df <- read.csv("WA_Fn-UseC_-HR-Employee-Attrition.csv")

# Convert numeric columns
df$Age <- as.numeric(df$Age)
df$MonthlyIncome <- as.numeric(df$MonthlyIncome)
df$YearsAtCompany <- as.numeric(df$YearsAtCompany)

# 1. SCATTER PLOT
# Age vs Monthly Income
ggplot(df, aes(x = Age, y = MonthlyIncome)) +
  geom_point(color = "blue") +
  labs(
    title = "Scatter Plot of Age vs Monthly Income",
    x = "Age",
    y = "Monthly Income"
  ) +
  theme_minimal()


# 2. PIE CHART
# Attrition Distribution
attrition_data <- df %>% count(Attrition)

ggplot(attrition_data, aes(x = "", y = n, fill = Attrition)) +
  geom_col(color = "black") +
  coord_polar(theta = "y") +
  labs(title = "Employee Attrition Distribution") +
  theme_void()


# 3. HIGH–LOW CHART
# Monthly Income Range by Department
# Create High and Low Income per Job Level
income_range <- df %>%
  group_by(JobLevel) %>%
  summarise(
    Low = min(MonthlyIncome, na.rm = TRUE),
    High = max(MonthlyIncome, na.rm = TRUE)
  )

ggplot(income_range, aes(x = as.factor(JobLevel))) +
  geom_linerange(aes(ymin = Low, ymax = High), color = "black") +
  labs(
    title = "High–Low Chart of Monthly Income by Job Level",
    x = "Job Level",
    y = "Monthly Income Range"
  ) +
  theme_minimal()


