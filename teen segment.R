# Load Data
data <- read.csv("C:/Users/aravi/Downloads/snsdata.csv")

# Preprocess: Exclude non-numeric columns (like 'gender')
numeric_data <- data[, sapply(data, is.numeric)]

# Preprocess: Handle Missing Values (Replace NA with column mean)
numeric_data <- data.frame(lapply(numeric_data, function(x) {
  ifelse(is.na(x), mean(x, na.rm = TRUE), x)
}))

# K-Means Clustering
set.seed(123)
clusters <- kmeans(numeric_data, centers = 3)

# Print Clusters
print(clusters)

# Add Cluster Assignments to the Data
data$Cluster <- as.factor(clusters$cluster)

# Plot Clustering Results
library(ggplot2)

# Visualize the First Two Features
ggplot(data, aes(x = numeric_data[, 1], y = numeric_data[, 2], color = Cluster)) +
  geom_point(size = 3) +
  labs(title = "K-Means Clustering Visualization", 
       x = "Feature 1", y = "Feature 2") +
  theme_minimal() +
  scale_color_manual(values = c("red", "blue", "green"))

