# Load the dplyr package
library(dplyr)

# Load the cars dataset
cars <- read.csv("carsprice.csv")

# Sort by Price_USD in ascending order (lowest to highest)
cars_sorted_price <- cars |>
  arrange(Price_USD)

# Check the first 5 rows—notice the low price values
head(cars_sorted_price, 5)

# Sort by Max_Power_bhp in descending order (highest to lowest)
cars_sorted_power_desc <- cars |>
  arrange(desc(Max_Power_bhp))

# Check the first 5 rows—notice the high power values
head(cars_sorted_power_desc, 5)

# Primary sort: Fuel_Type (Ascending)
# Secondary sort: Mileage_kmpl (Descending, highest first)
cars_multi_sort <- cars |>
  arrange(Fuel_Type, desc(Mileage_kmpl))
head(cars_multi_sort, 10)

# Filter for powerful engines, then arrange by Price_USD
large_engines_by_price <- cars |>
  filter(Engine_CC > 3000) |>
  arrange(Price_USD)

cat("Top 5 high-engine cars with lowest prices:\n")

# Check the Engine_CC and Price_USD columns for confirmation
print(
  large_engines_by_price |>
    select(Engine_CC, Price_USD, Max_Power_bhp) |>
    head(5)
)

