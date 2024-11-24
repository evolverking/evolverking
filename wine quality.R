# Install and load necessary packages
install.packages("rpart")
install.packages("RWeka")
install.packages("caret")
install.packages("partykit")

library(rpart)
library(RWeka)
library(caret)
library(partykit)

# Load the wine quality dataset
wine_data <- read.csv("C:/Users/aravi/Downloads/wine+quality/winequality-red.csv", sep = ";")
head(wine_data)

# Preprocess the data
wine_data <- na.omit(wine_data)

# Split the data into training and testing sets (80% train, 20% test)
set.seed(123)
trainIndex <- createDataPartition(wine_data$quality, p = 0.8, list = FALSE)
train_data <- wine_data[trainIndex, ]
test_data <- wine_data[-trainIndex, ]

# Build the regression tree model using rpart
rt_model <- rpart(quality ~ ., data = train_data, method = "anova")
summary(rt_model)
plot(rt_model)
text(rt_model, use.n = TRUE)

# Build the model tree using M5P from RWeka
mt_model <- M5P(quality ~ ., data = train_data)
summary(mt_model)
plot(mt_model)

# Make predictions and evaluate models
rt_predictions <- predict(rt_model, newdata = test_data)
mt_predictions <- predict(mt_model, newdata = test_data)

# RMSE for both models
rt_rmse <- sqrt(mean((rt_predictions - test_data$quality)^2))
mt_rmse <- sqrt(mean((mt_predictions - test_data$quality)^2))

# R-squared for both models
rt_r2 <- cor(rt_predictions, test_data$quality)^2
mt_r2 <- cor(mt_predictions, test_data$quality)^2

# Print the results
cat("RMSE for Regression Tree: ", rt_rmse, "\n")
cat("RMSE for Model Tree: ", mt_rmse, "\n")
cat("R-squared for Regression Tree: ", rt_r2, "\n")
cat("R-squared for Model Tree: ", mt_r2, "\n")

