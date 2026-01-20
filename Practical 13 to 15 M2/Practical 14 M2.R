# S101 RAJDEEP M PARAB
# PRACTICAL 14 – Logistic Regression using glm()
# 1. Load data 
# Use 'modified_binary.csv' for a more prominent S-curve
df <- read.csv("binary.csv")

# 2. Perform Logistic Regression using glm()
# admit is the dependent variable (Y), gre is the predictor (X)
model <- glm(admit ~ gre, data = df, family = "binomial")

# 3. Create a range of GRE values for a smooth S-curve plot
x_range <- seq(min(df$gre), max(df$gre), length.out = 200)

# 4. Predict probabilities using the fitted model
y_probs <- predict(model, newdata = data.frame(gre = x_range), type = "response")

# Create data frame for plotting the curve
logistic_df <- data.frame(gre = x_range, admit = y_probs)

# 5. Plot the Data points and the Fitted S-Curve
library(ggplot2)
ggplot(df, aes(x = gre, y = admit)) +
  geom_point(alpha = 0.3, color = "black") +  # Actual data points (0 or 1)
  geom_line(data = logistic_df, aes(x = gre, y = admit), color = "red", linewidth = 1.5) +
  scale_y_continuous(limits = c(0, 1)) +
  labs(
    title = "Logistic Regression Curve (admit ~ gre)",
    subtitle = "Proper S-shaped Curve fitted via glm()",
    x = "GRE Score",
    y = "Probability of Admission"
  ) +
  theme_minimal()


