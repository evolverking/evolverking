# Install and load necessary packages
install.packages("rpart")
install.packages("rpart.plot")
install.packages("caret")

library(rpart)
library(rpart.plot)
library(caret)

# Example dataset for demonstration
data <- data.frame(
  income = c(50000, 60000, 70000, 80000, 90000, 30000, 40000),
  loan_amount = c(20000, 25000, 30000, 35000, 40000, 10000, 15000),
  credit_score = c(650, 700, 750, 800, 850, 620, 630),
  loan_approved = factor(c("Yes", "Yes", "Yes", "Yes", "Yes", "No", "No")),
  risky_loan = factor(c(0, 0, 0, 0, 0, 1, 1))  # 1 = Risky, 0 = Not Risky
)

# View the dataset
head(data)

# Set seed for reproducibility
set.seed(123)

# Split the data into training and testing sets (80% train, 20% test)
trainIndex <- createDataPartition(data$risky_loan, p = 0.8, list = FALSE)
train_data <- data[trainIndex, ]
test_data <- data[-trainIndex, ]

# Build the Decision Tree model
dt_model <- rpart(risky_loan ~ income + loan_amount + credit_score + loan_approved, 
                  data = train_data, method = "class")

# View the model summary
summary(dt_model)

# Plot the decision tree
rpart.plot(dt_model, main = "Decision Tree for Risky Bank Loans", extra = 1)

# Make predictions on the test data
predictions <- predict(dt_model, newdata = test_data, type = "class")

# Compare actual vs predicted
comparison <- data.frame(Actual = test_data$risky_loan, Predicted = predictions)
head(comparison)

# Evaluate the model using confusion matrix
confusion_matrix <- confusionMatrix(predictions, test_data$risky_loan)
print(confusion_matrix)

# Accuracy
accuracy <- sum(predictions == test_data$risky_loan) / nrow(test_data)
cat("Accuracy: ", accuracy, "\n")
