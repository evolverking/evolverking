# Install the arules package if not already installed
if (!require(arules)) install.packages("arules", dependencies=TRUE)

# Load the arules package
library(arules)

# Create the dataset from the given data
transactions <- data.frame(
  TransactionItem = c("Bread", "Scandinavian", "Scandinavian", "Hot chocolate", "Jam", "Cookies", "Muffin", "Coffee", 
                      "Pastry", "Bread", "Medialuna", "Pastry", "Muffin", "Medialuna", "Pastry", "Coffee", "Tea", 
                      "Pastry", "Bread", "Scandinavian", "Medialuna", "Bread", "Medialuna", "Bread", "Jam", "Coffee", 
                      "Tartine", "Pastry"),
  stringsAsFactors = FALSE
)

# Convert the transaction data into a transactions format
# We will use the item names to create transactions
transaction_data <- as(split(transactions$TransactionItem, seq(nrow(transactions))), "transactions")

# View the transactions
inspect(transaction_data)

# Apply the apriori algorithm to find association rules
# Set the support and confidence thresholds
rules <- apriori(transaction_data, parameter = list(support = 0.1, confidence = 0.6))

# View the generated rules
inspect(rules)

# You can sort the rules by lift or confidence
sorted_rules <- sort(rules, by = "lift", decreasing = TRUE)
inspect(sorted_rules)

# If you're looking for fraudulent claims, you could look for patterns that seem unusual or unexpected
# For example, if a product is frequently bought with items it normally wouldn't be, it could suggest fraudulent claims

# Plot the rules
library(arulesViz)
plot(sorted_rules)
