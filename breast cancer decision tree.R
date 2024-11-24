# Install necessary packages if not already installed
if (!require(rpart)) install.packages("rpart", dependencies=TRUE)
if (!require(rpart.plot)) install.packages("rpart.plot", dependencies=TRUE)

# Load the libraries
library(rpart)
library(rpart.plot)

# Load the Breast Cancer dataset (can be loaded from UCI or local CSV file)
# For demonstration, we use the built-in `BreastCancer` dataset from the `mlbench` package
if (!require(mlbench)) install.packages("mlbench", dependencies=TRUE)
library(mlbench)
data(BreastCancer)

# View the structure of the dataset
str(BreastCancer)

# Preprocessing: Remove the 'ID' column (if any) and missing values
# The 'ID' column is a non-numeric identifier and doesn't contribute to model building
BreastCancer <- BreastCancer[ , -1]

# Remove rows with missing values (if any)
BreastCancer <- na.omit(BreastCancer)

# Convert the diagnosis column to factor (if it's not already)
BreastCancer$Class <- factor(BreastCancer$Class, levels = c("benign", "malignant"))

# Split the data into training and testing sets (80% train, 20% test)
set.seed(123)  # For reproducibility
trainIndex <- sample(1:nrow(BreastCancer), 0.8 * nrow(BreastCancer))
trainData <- BreastCancer[trainIndex, ]
testData <- BreastCancer[-trainIndex, ]

# Train the decision tree model
model <- rpart(Class ~ ., data = trainData, method = "class")

# Print the model summary
print(model)

# Plot the decision tree
rpart.plot(model, main = "Breast Cancer Diagnosis Decision Tree", type = 3, extra = 101)

# Evaluate the model on the test data
predictions <- predict(model, testData, type = "class")

# Confusion matrix to evaluate the performance
confusionMatrix <- table(Predicted = predictions, Actual = testData$Class)
print(confusionMatrix)

# Calculate accuracy
accuracy <- sum(predictions == testData$Class) / length(testData$Class)
cat("Accuracy of the Decision Tree Model: ", accuracy, "\n")
