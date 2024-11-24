# Load Required Libraries
library(caret)

# Load Data
data <- read.csv("C:/Users/aravi/Downloads/concrete_data.csv")

# Rename the target variable for easier handling
colnames(data)[ncol(data)] <- "Strength"

# Split Data into Training and Testing Sets
set.seed(123)
trainIndex <- createDataPartition(data$Strength, p = 0.8, list = FALSE)
trainData <- data[trainIndex, ]
testData <- data[-trainIndex, ]

# Linear Regression Model
model <- lm(Strength ~ ., data = trainData)

# Predictions on Test Data
predictions <- predict(model, newdata = testData)

# Plot Predicted vs. Actual Values
plot(testData$Strength, predictions, 
     xlab = "Actual Strength", ylab = "Predicted Strength", 
     main = "Predicted vs. Actual Strength",
     col = "blue", pch = 16)
abline(0, 1, col = "red", lwd = 2)  # Add a reference line


