# R Script: Extracting Date Components using lubridate
# Dataset: Student Attendance

# Load necessary libraries
install.packages("lubridate")
# install.packages("dplyr")

library(lubridate)
library(dplyr)
# 1. SETUP: Create Sample Student Attendance Data
# We start with attendance dates stored as character text (YYYY-MM-DD)

attendance_df <- data.frame(
  Student_ID = 1:4,
  Attendance_Date = c("2023-06-15", "2023-10-31", "2024-02-29", "2024-12-01")
)
print("--- 1. Original Student Attendance Data ---")
print(attendance_df)


# 2. PARSE AND EXTRACT DATE COMPONENTS
processed_data <- attendance_df %>%
  mutate(
    # A. Parsing: Convert text to Date (Year-Month-Day)
    Actual_Date = ymd(Attendance_Date),
    
    # B. Extraction Functions
    Year_Num = year(Actual_Date),                         
    Month_Num = month(Actual_Date),                        
    Month_Name = month(Actual_Date, label = TRUE),         
    Day_Num = day(Actual_Date),                            
    Weekday_Num = wday(Actual_Date),                       
    Weekday_Name = wday(Actual_Date, label = TRUE, abbr = FALSE),  
    Quarter = quarter(Actual_Date),                       
    Day_of_Year = yday(Actual_Date)                       
  )

print("--- Data with Extracted Date Components (Student Attendance) ---")
print(processed_data)


# 3. System Date: Handling "Now"
# Extracting components from the current system timestamp

current_time <- now()

print("--- Current System Time Extraction ---")
print(paste("Current Year:", year(current_time)))
print(paste("Current Hour:", hour(current_time)))
print(paste("Current Minute:", minute(current_time)))
