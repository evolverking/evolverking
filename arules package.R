# Install required packages
install.packages("arules")
install.packages("arulesViz")

# Load the necessary libraries
library(arules)
library(arulesViz)

# Load the Groceries dataset
data("Groceries")

# Apply the apriori algorithm to find association rules
rules <- apriori(Groceries, parameter = list(support = 0.01, confidence = 0.5))

# View the first few rules
inspect(head(rules))

# Filter rules with high lift
high_lift_rules <- subset(rules, lift > 2)

# Inspect the filtered rules
inspect(high_lift_rules)

# Visualize the rules
plot(rules, method = "scatter")

# Save the rules to a file
write(rules, file = "association_rules.txt", sep = "\n")
write.csv(as(rules, "data.frame"), file = "association_rules.csv")

