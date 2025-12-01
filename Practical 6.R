#6. Combining and appending datasets using merge() or bind_rows() in R.
library(dplyr)
# 1. Create datasets
# Dataset 1: Attendance in January
data_jan <- data.frame(
  ID = c(1, 2, 3),
  Name = c("Amit", "Sneha", "Rohit"),
  Jan_Attendance = c(20, 18, 22)      # Number of days present in January
)
# Dataset 2: Attendance in February
data_feb <- data.frame(
  ID = c(1, 2, 3),
  Name = c("Amit", "Sneha", "Rohit"),
  Feb_Attendance = c(19, 20, 21)      # Days present in February
)
# Dataset 3: New Students added in March
data_new_students <- data.frame(
  ID = c(4, 5),
  Name = c("Prathamesh", "Kunal"),
  Jan_Attendance = c(0, 0)            # They joined after January
)

# 2. MERGE: Combine January + February attendance
merged_data <- merge(data_jan, data_feb, by = c("ID", "Name"))
print("--- Merged Attendance Data ---")
print(merged_data)

# 3. APPEND: Add newly joined students
final_list <- bind_rows(data_jan, data_new_students)
print("--- Attendance List After Adding New Students ---")
print(final_list)
