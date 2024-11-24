# Install and load necessary packages
install.packages(c("class", "caret", "mlbench"))
library(class)
library(caret)
library(mlbench)

# Load and preprocess the dataset
data("BreastCancer")
bc_data <- na.omit(BreastCancer[, -1])  # Remove 'ID' column and rows with missing values
bc_data$Class <- factor(bc_data$Class, levels = c("benign", "malignant"))

# Split the data into training and test sets (80% train, 20% test)
set.seed(123)
trainIndex <- createDataPartition(bc_data$Class, p = 0.8, list = FALSE)
train_data <- bc_data[trainIndex, ]
test_data <- bc_data[-trainIndex, ]

# Train the kNN model (k = 5)
knn_model <- knn(train = train_data[, -ncol(train_data)], 
                 test = test_data[, -ncol(test_data)], 
                 cl = train_data$Class, k = 5)

# Evaluate the model
conf_matrix <- confusionMatrix(knn_model, test_data$Class)
print(conf_matrix)
cat("Accuracy: ", sum(knn_model == test_data$Class) / length(test_data$Class), "\n")

