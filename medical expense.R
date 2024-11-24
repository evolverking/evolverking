# Install and load necessary packages
install.packages("caret")
install.packages("ggplot2")

library(caret)
library(ggplot2)

# Load the dataset
data <- read.csv("C:/Users/aravi/Downloads/insurance.csv")

# Convert categorical variables into factors
data$sex <- factor(data$sex, levels = c("female", "male"))
data$smoker <- factor(data$smoker, levels = c("no", "yes"))
data$region <- factor(data$region)

# Split data into training and testing sets (80% train, 20% test)
set.seed(123)
trainIndex <- createDataPartition(data$charges, p = 0.8, list = FALSE)
train_data <- data[trainIndex, ]
test_data <- data[-trainIndex, ]

# Build the linear regression model
lm_model <- lm(charges ~ age + sex + bmi + children + smoker + region, data = train_data)

# View the model summary
summary(lm_model)

# Make predictions on the test data
predictions <- predict(lm_model, newdata = test_data)

# Compare predictions with actual charges
comparison <- data.frame(Actual = test_data$charges, Predicted = predictions)
head(comparison)

# Evaluate the model performance (RMSE and R-squared)
rmse <- sqrt(mean((predictions - test_data$charges)^2))
cat("RMSE: ", rmse, "\n")

rsq <- 1 - sum((predictions - test_data$charges)^2) / sum((mean(test_data$charges) - test_data$charges)^2)
cat("R-squared: ", rsq, "\n")
