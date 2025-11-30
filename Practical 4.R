# Install packages (run once)
install.packages(c("dplyr", "readxl"))

# Load libraries
library(dplyr)
library(readxl)

# Load the dataset
students <- read_excel("StudentsPerformance.xlsx")

# Quick look at the dataset
head(students)


# ============================================================
# METHOD 1: subset() — Base R
# ============================================================

# Example 1: Students with math score > 90
high_math <- subset(students, `math score` > 90)
cat("Number of high math scorers (>90):", nrow(high_math), "\n")
summary(high_math$`math score`)


# Example 2: Multiple Conditions (AND)
# Students with reading score > 90 AND writing score > 90
high_read_write <- subset(students,
                          `reading score` > 90 & `writing score` > 90)
cat("Students with reading >90 AND writing >90:", nrow(high_read_write), "\n")
head(high_read_write)


# Example 3: OR Condition
# Students who completed test preparation OR have math score > 90
special_students <- subset(students,
                           `test preparation course` == "completed" |
                             `math score` > 90)
cat("Students who completed test prep OR scored >90 in math:",
    nrow(special_students), "\n")
head(special_students)



# ============================================================
# METHOD 2: dplyr::filter()
# ============================================================

# Example 1: Single condition using pipe
low_math <- students |>
  filter(`math score` < 50)

cat("Students with math score < 50:", nrow(low_math), "\n")
summary(low_math$`math score`)


# Example 2: Multiple Conditions (AND, using comma)
# Students who got "standard" lunch AND math score > 70
std_lunch_high_math <- students |>
  filter(lunch == "standard", `math score` > 70)

cat("Students with standard lunch & math >70:", nrow(std_lunch_high_math), "\n")
head(std_lunch_high_math)


# Example 3: %in% for matching values
# Students from race/ethnicity groups B or C
group_BC <- students |>
  filter(`race/ethnicity` %in% c("group B", "group C"))

cat("Students from groups B or C:", nrow(group_BC), "\n")
table(group_BC$`race/ethnicity`)
