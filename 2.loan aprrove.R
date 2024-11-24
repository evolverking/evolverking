# Install and load necessary packages
install.packages(c("caret", "randomForest", "dplyr", "mlbench"))
library(caret)
library(randomForest)
library(dplyr)
library(mlbench)

# Load and preprocess the dataset (use a similar dataset like UCI Bank Credit)
# For the purpose of this example, let's assume we're using the 'GermanCredit' dataset from the mlbench package
data("GermanCredit")
df <- GermanCredit

# View the structure of the dataset
str(df)

# Handle missing values (if any)
df <- na.omit(df)  # Remove rows with NA values

# Convert 'Class' to factor (Loan status: "Good" or "Bad")
df$Class <- factor(df$Class, levels = c("Bad", "Good"))

# Split the data into training and testing sets (80% train, 20% test)
set.seed(123)
trainIndex <- createDataPartition(df$Class, p = 0.8, list = FALSE)
train_data <- df[trainIndex, ]
test_data <- df[-trainIndex, ]

# Train a Random Forest model (as an example of machine learning model)
rf_model <- randomForest(Class ~ ., data = train_data, importance = TRUE)

# Predict on the test set
rf_predictions <- predict(rf_model, test_data)

# Evaluate the model using confusion matrix
conf_matrix <- confusionMatrix(rf_predictions, test_data$Class)
print(conf_matrix)

# Accuracy of the model
cat("Accuracy: ", conf_matrix$overall['Accuracy'], "\n")
