# Install caret (for machine learning utilities)
install.packages("caret")

# Install e1071 (for machine learning and statistical functions)
install.packages("e1071")

# Install ggplot2 (for data visualization)
install.packages("ggplot2")

# Install dplyr (for data manipulation)
install.packages("dplyr")

# Load required libraries
library(caret)
library(e1071)
library(ggplot2)
library(dplyr)

# Step 1: Load a simple dataset
# Example data: Replace with your own or create a CSV file
data <- data.frame(
  Income = c(30000, 40000, 50000, 20000, 100000, 60000, 25000, 45000, 120000, 70000),
  CreditScore = c(600, 650, 700, 550, 800, 750, 580, 690, 850, 720),
  Employment = as.factor(c("Yes", "Yes", "Yes", "No", "Yes", "Yes", "No", "Yes", "Yes", "Yes")),
  LoanApproved = as.factor(c(0, 1, 1, 0, 1, 1, 0, 1, 1, 1)) # Target variable
)

# Step 2: Summarize the dataset
print("Dataset Summary:")
summary(data)

# Step 3: Exploratory Data Analysis (EDA)
print("Visualizing Income vs. Loan Approval")
ggplot(data, aes(x = Income, fill = LoanApproved)) +
  geom_histogram(binwidth = 10000, position = "dodge") +
  labs(title = "Income Distribution by Loan Approval", x = "Income", y = "Count")

print("Visualizing Credit Score vs. Loan Approval")
ggplot(data, aes(x = CreditScore, fill = LoanApproved)) +
  geom_histogram(binwidth = 50, position = "dodge") +
  labs(title = "Credit Score Distribution by Loan Approval", x = "Credit Score", y = "Count")

# Step 4: Data Preprocessing
# Convert categorical variables to numeric (if necessary)
data$Employment <- as.numeric(data$Employment)

# Split data into training and testing sets
set.seed(123) # For reproducibility
index <- createDataPartition(data$LoanApproved, p = 0.8, list = FALSE)
train <- data[index, ]
test <- data[-index, ]

# Step 5: Train a Logistic Regression Model
model <- glm(LoanApproved ~ ., data = train, family = binomial)

# Step 6: Evaluate the Model
summary(model)

# Predictions
predictions <- predict(model, test, type = "response")
predicted_classes <- ifelse(predictions > 0.5, 1, 0)

# Confusion Matrix
confusion_matrix <- confusionMatrix(as.factor(predicted_classes), test$LoanApproved)
print("Confusion Matrix:")
print(confusion_matrix)

# Accuracy
accuracy <- sum(predicted_classes == test$LoanApproved) / nrow(test)
cat("Accuracy: ", accuracy, "\n")

# Step 7: Visualizing Model Predictions
test$Predicted <- as.factor(predicted_classes)
ggplot(test, aes(x = CreditScore, y = Income, color = Predicted)) +
  geom_point(size = 3) +
  labs(title = "Predictions by Credit Score and Income", x = "Credit Score", y = "Income")
