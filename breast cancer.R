# Load required libraries
library(caret)      # For data splitting and evaluation
library(class)       # For k-NN algorithm
library(ggplot2)     # For data visualization
library(dplyr)       # For data manipulation

# Step 1: Create the dataset
data <- data.frame(
  Radius = c(14.5, 18.2, 13.3, 12.1, 15.0, 20.2, 10.1, 17.4, 12.7, 16.8), # Mean radius
  Texture = c(19.2, 21.1, 16.3, 14.2, 18.4, 23.1, 13.1, 20.5, 15.0, 21.9), # Mean texture
  Perimeter = c(89.8, 102.4, 78.5, 72.2, 90.6, 120.2, 68.3, 99.2, 74.8, 105.4), # Mean perimeter
  Area = c(600, 1100, 520, 450, 800, 1300, 300, 950, 480, 1120), # Mean area
  Smoothness = c(0.092, 0.088, 0.101, 0.098, 0.091, 0.080, 0.102, 0.084, 0.094, 0.082), # Mean smoothness
  Diagnosis = as.factor(c(0, 1, 0, 0, 1, 1, 0, 1, 0, 1)) # Diagnosis (0 = Benign, 1 = Malignant)
)

# Step 2: Inspect the dataset
print("Dataset Head:")
head(data)
summary(data)

# Step 3: Normalize numerical features (important for k-NN)
normalize <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}

# Apply normalization to numeric columns
normalized_data <- as.data.frame(lapply(data[, 1:5], normalize))
normalized_data$Diagnosis <- data$Diagnosis  # Append the target variable back

print("Normalized Dataset:")
head(normalized_data)

# Step 4: Split data into training and testing sets
set.seed(123)  # For reproducibility
trainIndex <- createDataPartition(normalized_data$Diagnosis, p = 0.8, list = FALSE)
train <- normalized_data[trainIndex, ]
test <- normalized_data[-trainIndex, ]

# Separate features and target variable
train_features <- train[, -6]  # Exclude Diagnosis
train_labels <- train$Diagnosis
test_features <- test[, -6]
test_labels <- test$Diagnosis

# Step 5: Apply the k-NN algorithm
k <- 3  # Choose number of neighbors
predictions <- knn(train = train_features, test = test_features, cl = train_labels, k = k)

# Step 6: Evaluate the model
conf_matrix <- confusionMatrix(predictions, test_labels)
print("Confusion Matrix:")
print(conf_matrix)

# Step 7: Visualize the predictions
test$Predicted <- as.numeric(predictions) - 1
ggplot(test, aes(x = Radius, y = Area, color = as.factor(Predicted))) +
  geom_point(size = 3) +
  labs(title = "k-NN Predictions", x = "Radius", y = "Area", color = "Prediction") +
  scale_color_manual(values = c("blue", "red"), labels = c("Benign", "Malignant"))

# Display accuracy
accuracy <- sum(predictions == test_labels) / nrow(test)
cat("Accuracy: ", accuracy, "\n")

