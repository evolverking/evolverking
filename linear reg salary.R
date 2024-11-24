# Creating the dataset
data <- data.frame(
  experience = c(1.1, 1.3, 1.5, 2.0, 2.2, 2.9, 3.0),
  salary = c(39343.00, 46205.00, 37731.00, 43525.00, 39891.00, 56642.00, 60150.00)
)

# View the data
print("Dataset:")
print(data)

# Implementing Linear Regression
# Linear model: Salary ~ Experience
model <- lm(salary ~ experience, data = data)

# Display the summary of the model
print("Linear Regression Model Summary:")
summary(model)

# Predicting the salary for a given experience (Example: 2.5 years of experience)
predicted_salary <- predict(model, newdata = data.frame(experience = 2.5))
print("Predicted Salary for 2.5 years of experience:")
print(predicted_salary)

# Plotting the data and the regression line
plot(data$experience, data$salary, main = "Linear Regression: Salary vs Experience", 
     xlab = "Years of Experience", ylab = "Salary", pch = 19, col = "blue")
abline(model, col = "red")
