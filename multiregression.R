# Creating the dataset
data <- data.frame(
  RnD_Spend = c(165349.2, 162597.7, 153441.5, 144372.4, 142107.3, 131876.9, 134615.5),
  Administration = c(136897.8, 151377.6, 101145.6, 118671.9, 91391.77, 99814.71, 147198.9),
  Marketing_Spend = c(471784.1, 443898.5, 407934.5, 383199.6, 366168.4, 362861.4, 127716.8)
)

# View the dataset
print("Dataset:")
print(data)

# Multiple Linear Regression Model
# Dependent variable (Y) could be any of the columns, for example, R&D Spend vs the other two features.
model <- lm(RnD_Spend ~ Administration + Marketing_Spend, data = data)

# Display the summary of the model
print("Multiple Linear Regression Model Summary:")
summary(model)

# Predicting R&D Spend for new data
new_data <- data.frame(Administration = 120000, Marketing_Spend = 400000)
predicted_RnD_Spend <- predict(model, newdata = new_data)

# Display the predicted value for new data
print("Predicted R&D Spend for Administration = 120000 and Marketing Spend = 400000:")
print(predicted_RnD_Spend)

# Plotting the data points and the regression line (if possible, otherwise, interpret the relationship)
# Here, we plot the relationships between the independent variables and the dependent variable
par(mfrow = c(1, 2))  # Setting up multiple plots in one row

# Plotting R&D Spend vs Administration
plot(data$Administration, data$RnD_Spend, 
     main = "R&D Spend vs Administration", 
     xlab = "Administration", ylab = "R&D Spend", 
     col = "blue", pch = 19)
abline(lm(RnD_Spend ~ Administration, data = data), col = "red")

# Plotting R&D Spend vs Marketing Spend
plot(data$Marketing_Spend, data$RnD_Spend, 
     main = "R&D Spend vs Marketing Spend", 
     xlab = "Marketing Spend", ylab = "R&D Spend", 
     col = "green", pch = 19)
abline(lm(RnD_Spend ~ Marketing_Spend, data = data), col = "red")
