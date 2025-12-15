# Dataset: Project Attendance
# 1. SETUP: Create Sample Project Attendance Data
project_df <- data.frame(
  Student_ID = 1:6,
  Project_Name = c("AI System", "Web App", "AI System", "Database", "Web App", "Database"),
  Attendance_Percent = c(85.5, 72.0, 91.0, NA, 68.0, 88.0),   # Note the NA
  Submitted = c(TRUE, TRUE, FALSE, TRUE, FALSE, TRUE),
  Performance_Rating = c(4.5, 3.8, 4.9, 4.0, 3.5, 4.2)
)
print("--- Data Loaded ---")
print(project_df)

# 2. USING str() (Structure)
print("--- OUTPUT OF str() ---")
str(project_df)

# 3. USING summary() (Statistical Summary)
print("--- OUTPUT OF summary() [Before Factor Conversion] ---")
summary(project_df)

# 4. IMPROVING summary() WITH FACTORS
project_df$Project_Name <- as.factor(project_df$Project_Name)
print("--- OUTPUT OF summary() [After Factor Conversion] ---")
summary(project_df)

# 5. Accessing Specific Summaries
avg_attendance <- mean(project_df$Attendance_Percent, na.rm = TRUE)
max_attendance <- max(project_df$Attendance_Percent, na.rm = TRUE)
print(paste("Average Project Attendance:", avg_attendance))
print(paste("Highest Project Attendance:", max_attendance))

