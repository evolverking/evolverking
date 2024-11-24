# Install and load necessary packages
install.packages("e1071")
install.packages("tm")
install.packages("caret")

library(e1071)
library(tm)
library(caret)

# Example SMS dataset with messages and labels (1 for spam, 0 for ham)
data <- data.frame(
  label = factor(c("ham", "spam", "ham", "ham", "spam", "ham", "spam", "ham")),
  message = c(
    "Hey, how are you?",
    "Free tickets to a concert, reply to claim your prize!",
    "Are we still meeting tomorrow?",
    "Call me when you get this message",
    "Congratulations! You've won a lottery, call us now!",
    "Let's grab lunch today",
    "Exclusive offer: Free phone with your plan, call us now!",
    "Please reply to confirm your appointment"
  )
)

# Text preprocessing function
preprocess_text <- function(text) {
  # Convert to lowercase
  text <- tolower(text)
  # Remove punctuation, numbers, and whitespace
  text <- removePunctuation(text)
  text <- removeNumbers(text)
  text <- stripWhitespace(text)
  return(text)
}

# Apply preprocessing to the message column
data$message <- sapply(data$message, preprocess_text)

# Create a corpus from the message data
corpus <- Corpus(VectorSource(data$message))

# Create a Document-Term Matrix (DTM)
dtm <- DocumentTermMatrix(corpus)

# Convert the DTM to a data frame
dtm_matrix <- as.data.frame(as.matrix(dtm))

# Add the label column to the DTM matrix
dtm_matrix$label <- data$label

# Split the data into training and testing sets (80% train, 20% test)
set.seed(123)
trainIndex <- createDataPartition(dtm_matrix$label, p = 0.8, list = FALSE)
train_data <- dtm_matrix[trainIndex, ]
test_data <- dtm_matrix[-trainIndex, ]

# Build the Naïve Bayes model
nb_model <- naiveBayes(label ~ ., data = train_data)

# Make predictions on the test data
predictions <- predict(nb_model, newdata = test_data)

# Compare actual vs predicted
comparison <- data.frame(Actual = test_data$label, Predicted = predictions)
head(comparison)

# Evaluate the model using confusion matrix
confusion_matrix <- confusionMatrix(predictions, test_data$label)
print(confusion_matrix)

# Accuracy
accuracy <- sum(predictions == test_data$label) / nrow(test_data)
cat("Accuracy: ", accuracy, "\n")

