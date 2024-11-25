# Load required libraries
library(ggplot2)  # For visualization
library(caret)    # For data splitting and evaluation

# Step 1: Create the simple medical expenses dataset
data <- data.frame(
  Age = c(25, 32, 47, 51, 22, 37, 29, 45, 34, 50),       # Age of the person
  BMI = c(22.4, 28.7, 35.2, 30.5, 18.9, 25.4, 24.7, 36.1, 28.9, 34.2),  # Body Mass Index
  Children = c(0, 1, 3, 2, 0, 1, 0, 3, 2, 1),             # Number of children
  Smoker = c(1, 0, 0, 1, 0, 0, 1, 1, 0, 1),               # Smoker status (1 = Smoker, 0 = Non-smoker)
  Region = as.factor(c("Northwest", "Southeast", "Southwest", "Northeast", "Northwest",
                       "Southeast", "Southwest", "Northeast", "Northwest", "Southeast")),  # Region
  Expenses = c(3200, 4100, 5200, 8500, 2300, 3700, 4400, 9000, 3100, 7800)  # Medical expenses (target variable)
)

# Inspect the dataset
print("Simple Medical Expenses Dataset:")
print(data)

# Step 2: Split data into training and testing sets
set.seed(123)  # For reproducibility
trainIndex <- createDataPartition(data$Expenses, p = 0.8, list = FALSE)
train <- data[trainIndex, ]
test <- data[-trainIndex, ]

# Step 3: Build the Linear Regression Model
model <- lm(Expenses ~ Age + BMI + Children + Smoker + Region, data = train)

# View model summary
summary(model)

# Step 4: Make predictions on the test set
predictions <- predict(model, test)

# Step 5: Evaluate the model
# Calculate Mean Absolute Error (MAE) and Root Mean Squared Error (RMSE)
mae <- mean(abs(predictions - test$Expenses))
rmse <- sqrt(mean((predictions - test$Expenses)^2))

cat("Mean Absolute Error (MAE): ", mae, "\n")
cat("Root Mean Squared Error (RMSE): ", rmse, "\n")

# Step 6: Visualize Actual vs Predicted Expenses
results <- data.frame(Actual = test$Expenses, Predicted = predictions)
ggplot(results, aes(x = Actual, y = Predicted)) +
  geom_point(color = "blue", size = 3) +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +
  labs(title = "Actual vs Predicted Medical Expenses",
       x = "Actual Expenses", y = "Predicted Expenses") +
  theme_minimal()

# Step 7: Residual Plot
residuals <- test$Expenses - predictions
ggplot(data = test, aes(x = predictions, y = residuals)) +
  geom_point(color = "green") +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Residual Plot",
       x = "Predicted Expenses", y = "Residuals") +
  theme_minimal()
