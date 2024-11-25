# Load required library
library(arules)

# Step 1: Create a simple transaction dataset in a data frame
data <- data.frame(
  TransactionID = c(1, 2, 3, 4, 5),
  Items = c(
    "Milk, Bread, Butter",
    "Bread, Butter",
    "Milk, Diaper, Beer",
    "Milk, Bread, Diaper, Beer",
    "Bread, Diaper, Butter"
  ),
  stringsAsFactors = FALSE
)

# Inspect the data
print("Transaction Data (Data Frame):")
print(data)

# Step 2: Convert data into a transaction format
# Split the "Items" column into lists of individual items
transaction_list <- strsplit(data$Items, ", ")
names(transaction_list) <- data$TransactionID

# Convert to a transaction object
transactions <- as(transaction_list, "transactions")

# Inspect the transactions
print("Transaction Data (Transaction Object):")
summary(transactions)
inspect(transactions)

# Step 3: Generate association rules using the Apriori algorithm
rules <- apriori(transactions, parameter = list(supp = 0.3, conf = 0.7))

# Inspect the generated rules
print("Generated Association Rules:")
inspect(rules)

# Step 4: Analyze the rules
# Sort rules by lift and inspect top rules
rules_sorted <- sort(rules, by = "lift")
print("Top Association Rules by Lift:")
inspect(rules_sorted[1:5])

# Step 5: Visualize the rules (optional, if arulesViz is installed)
if (require(arulesViz)) {
  plot(rules_sorted, method = "graph", control = list(type = "items"))
}

