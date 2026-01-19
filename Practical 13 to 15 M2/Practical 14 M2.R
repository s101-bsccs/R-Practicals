# ====================================================
# PRACTICAL 14 – Logistic Regression using glm()
# Proper S-shaped Logistic Curve
# ====================================================

# Load required libraries
library(ggplot2)
library(dplyr)

# ----------------------------------------------------
# 1. Load dataset
# ----------------------------------------------------
df <- read.csv("binary.csv")

# ----------------------------------------------------
# 2. Select required columns
# admit = binary dependent variable (0/1)
# gpa = independent variable (X-axis)
# ----------------------------------------------------
df_log <- df %>%
  select(admit, gpa) %>%
  na.omit()

# ----------------------------------------------------
# 3. Fit Logistic Regression Model
# ----------------------------------------------------
log_model <- glm(admit ~ gpa,
                 data = df_log,
                 family = binomial)

# ----------------------------------------------------
# 4. Create values for smooth S-shaped curve
# ----------------------------------------------------
gpa_seq <- seq(min(df_log$gpa),
               max(df_log$gpa),
               length.out = 100)

predicted_prob <- predict(
  log_model,
  newdata = data.frame(gpa = gpa_seq),
  type = "response"
)

plot_df <- data.frame(
  gpa = gpa_seq,
  probability = predicted_prob
)

# ----------------------------------------------------
# 5. Plot Logistic Regression Curve (LIKE IMAGE)
# ----------------------------------------------------
ggplot() +
  geom_point(data = df_log,
             aes(x = gpa, y = admit),
             color = "black",
             size = 2) +
  geom_line(data = plot_df,
            aes(x = gpa, y = probability),
            color = "blue",
            linewidth = 1.2) +
  scale_y_continuous(limits = c(0, 1)) +
  labs(
    title = "Logistic Regression Curve",
    x = "GPA (X)",
    y = "Probability of Admission (Y)"
  ) +
  theme_minimal()
