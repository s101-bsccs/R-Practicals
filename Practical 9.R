# PRACTICAL 9 – . Performing text manipulation using  str_sub(), str_split() (R). import dataset.
# Functions: str_sub(), str_split()
# Dataset: Video_Games_Sales_as_at_22_Dec_2016.csv
library(stringr)
library(tidyr)
library(dplyr)
# 1. IMPORT DATASET
games <- read.csv("Video_Games_Sales_as_at_22_Dec_2016.csv", 
                  na.strings = c("", "NA"))
cat("\n--- Original Data (First 5 Rows) ---\n")
print(head(games, 5))

# 2. USING str_sub() – Extracting substrings
# We apply substring logic to the game "Name" column.
# A) Get first 5 characters of the game title
games$Title_Start <- str_sub(games$Name, 1, 5)
# B) Get last 4 characters of the game title
games$Title_End <- str_sub(games$Name, -4, -1)
cat("\n--- After str_sub() ---\n")
print(games %>% select(Name, Title_Start, Title_End) %>% head(5))

# 3. USING str_split() – Splitting text
# Example: Split the 'Name' column if it contains a colon ":".
# Titles with subtitles ("Halo: Reach", "Call of Duty: Ghosts")
games$Split_Name_List <- str_split(games$Name, ":", simplify = FALSE)
cat("\n--- Example of str_split() List Output ---\n")
print(games$Split_Name_List[[1]])   # first game's split info

# Optional: Convert to matrix for easier column assignment
split_matrix <- str_split(games$Name, ":", simplify = TRUE)
games$Main_Title <- trimws(split_matrix[, 1])
games$Sub_Title  <- trimws(split_matrix[, 2])
cat("\n--- After Splitting Game Title into Main & Subtitle ---\n")
print(games %>% select(Name, Main_Title, Sub_Title) %>% head(10))


# 4. BONUS: Tidyverse Approach – Using separate()
# If the Name column contains ":" separate automatically.
games_tidy <- games %>%
  separate(Name, into = c("Main_Title2", "Sub_Title2"), sep = ":", fill = "right")
cat("\n--- Using separate() (Cleaner Splitting) ---\n")
print(games_tidy %>% select(Main_Title2, Sub_Title2) %>% head(10))
