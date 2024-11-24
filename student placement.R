# Install and load the neuralnet package
if (!require(neuralnet)) install.packages("neuralnet", dependencies = TRUE)
library(neuralnet)

# Prepare the data
data <- data.frame(
  TechnicalKnowledge = c(20, 10, 30, 20, 80, 30),
  CommunicationSkills = c(90, 20, 40, 50, 50, 80),
  StudentStatus = factor(c("Placed", "Not placed", "Not placed", "Not placed", "Placed", "Placed"), levels = c("Not placed", "Placed"))
)

# Convert the target variable to numeric for training the model
data$StudentStatus <- as.numeric(data$StudentStatus) - 1

# Build the Neural Network model
nn_model <- neuralnet(StudentStatus ~ TechnicalKnowledge + CommunicationSkills, 
                      data = data, 
                      hidden = c(2), # 2 neurons in the hidden layer
                      linear.output = FALSE)

# Plot the neural network
plot(nn_model)

# Test the model
test_data <- data.frame(TechnicalKnowledge = c(25, 35),
                        CommunicationSkills = c(60, 75))

predictions <- predict(nn_model, test_data)

# Print predictions
print(predictions)
