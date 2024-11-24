# Prepare the dataset for squaring numbers
data_square <- data.frame(
  Input = 0:10,
  Output = (0:10)^2
)

# Load the neuralnet package
library(neuralnet)

# Build the Neural Network for squaring numbers
nn_square <- neuralnet(Output ~ Input, 
                       data = data_square, 
                       hidden = c(5),  # 5 neurons in the hidden layer
                       linear.output = TRUE)

# Plot the neural network
plot(nn_square)

# Test the model by predicting the square of a new number
test_input <- data.frame(Input = c(11, 12, 13))
predictions_square <- predict(nn_square, test_input)

# Print predictions for new inputs
print(predictions_square)
