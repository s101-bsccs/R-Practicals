# ============================================================
# PRACTICAL 10 – Graphical Reports using ggplot2
# ============================================================

# 1. LOAD LIBRARIES
library(ggplot2)
library(dplyr)

# 2. LOAD DATA FROM YOUR FULL PATH (already working for you)
WA_Fn.UseC_.HR.Employee.Attrition <- read.csv(
  "C:/Users/rajde/OneDrive/Rajdeep's File/Data Analysis with SAS,SPSS, R/Practical 10 to 12 (M2)/WA_Fn-UseC_-HR-Employee-Attrition.csv",
  header = FALSE
)

# 3. FIX HEADER ROW (because header = FALSE)
colnames(WA_Fn.UseC_.HR.Employee.Attrition) <- WA_Fn.UseC_.HR.Employee.Attrition[1, ]
df <- WA_Fn.UseC_.HR.Employee.Attrition[-1, ]

# 4. CHECK DATA (optional)
head(df)

# ------------------------------------------------------------
# 5. BAR CHART : Employee count by Department
# ------------------------------------------------------------
ggplot(df, aes(x = Department)) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(
    title = "Employee Count by Department",
    x = "Department",
    y = "Number of Employees"
  ) +
  theme_minimal()

# ------------------------------------------------------------
# 6. PIE CHART : Attrition Distribution
# ------------------------------------------------------------
attrition_data <- df %>% count(Attrition)

ggplot(attrition_data, aes(x = "", y = n, fill = Attrition)) +
  geom_col(color = "black") +
  coord_polar(theta = "y") +
  labs(title = "Attrition Distribution") +
  theme_void()

# ------------------------------------------------------------
# 7. LINE GRAPH : Age vs Monthly Income
# ------------------------------------------------------------
# convert numeric columns (because header=FALSE made all character)
df$Age <- as.numeric(df$Age)
df$MonthlyIncome <- as.numeric(df$MonthlyIncome)

ggplot(df, aes(x = Age, y = MonthlyIncome)) +
  geom_line(color = "blue") +
  labs(
    title = "Monthly Income Trend by Age",
    x = "Age",
    y = "Monthly Income"
  ) +
  theme_minimal()

# ------------------------------------------------------------
# 8. SCATTER PLOT : Age vs Years at Company
# ------------------------------------------------------------
df$YearsAtCompany <- as.numeric(df$YearsAtCompany)

ggplot(df, aes(x = Age, y = YearsAtCompany)) +
  geom_point(color = "red") +
  labs(
    title = "Scatter Plot: Age vs Years at Company",
    x = "Age",
    y = "Years at Company"
  ) +
  theme_minimal()

# ------------------------------------------------------------
# 9. GROUPED BAR PLOT : Attrition by Gender
# ------------------------------------------------------------
ggplot(df, aes(x = Gender, fill = Attrition)) +
  geom_bar(position = "dodge") +
  labs(
    title = "Attrition by Gender",
    x = "Gender",
    y = "Count"
  ) +
  theme_minimal()

