# Install and load necessary packages
install.packages(c("ggplot2", "caret"))
library(ggplot2)
library(caret)

# 1. Data Structures

# Vectors
vec <- c(1, 2, 3, 4, 5)
print("Vector:")
print(vec)

# Factors
gender <- factor(c("Male", "Female", "Male", "Female"))
print("Factor:")
print(gender)

# Lists
my_list <- list(name = "John", age = 25, scores = c(80, 90, 100))
print("List:")
print(my_list)

# Data Frames
df <- data.frame(
  name = c("Alice", "Bob", "Charlie"),
  age = c(25, 30, 35),
  score = c(88, 92, 95)
)
print("Data Frame:")
print(df)

# Matrices
mat <- matrix(1:9, nrow = 3, ncol = 3)
print("Matrix:")
print(mat)

# Arrays (3D)
arr <- array(1:24, dim = c(2, 3, 4))
print("Array:")
print(arr)

# 2. Data Distribution Charts

# Example Data (Random Normal Distribution)
set.seed(123)
data <- data.frame(
  age = rnorm(100, mean = 30, sd = 5),
  income = rnorm(100, mean = 50000, sd = 10000)
)

# 1. Pie Chart
categories <- c("Male", "Female", "Other")
counts <- c(60, 30, 10)
print("Pie Chart:")
pie(counts, labels = categories, main = "Gender Distribution", col = c("lightblue", "lightgreen", "lightcoral"))

# 2. Histogram
print("Histogram of Age Distribution:")
ggplot(data, aes(x = age)) +
  geom_histogram(binwidth = 1, fill = "lightblue", color = "black") +
  ggtitle("Histogram of Age Distribution") +
  xlab("Age") +
  ylab("Frequency")

# 3. Scatter Plot
print("Scatter Plot of Age vs Income:")
ggplot(data, aes(x = age, y = income)) +
  geom_point(color = "blue") +
  ggtitle("Scatter Plot of Age vs Income") +
  xlab("Age") +
  ylab("Income")

# 4. Box Plot
print("Box Plot of Age Distribution:")
ggplot(data, aes(y = age)) +
  geom_boxplot(fill = "lightblue") +
  ggtitle("Box Plot of Age Distribution") +
  ylab("Age")

# 3. Identify Outliers (Box Plot)
print("Identifying Outliers using Box Plot:")
ggplot(data, aes(y = age)) +
  geom_boxplot(fill = "lightblue") +
  ggtitle("Box Plot of Age Distribution (Outliers)") +
  ylab("Age")
