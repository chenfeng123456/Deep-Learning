# GRADED FUNCTION: predict

import numpy as np
from backward_propagation import backward_propagation
from compute_cost import compute_cost
from forward_propagation import forward_propagation
from initialize_parameters import initialize_parameters
from layer_sizes import layer_sizes
from update_parameters import update_parameters
from testCases_v2 import *
from sigmoid import sigmoid
import matplotlib as plt
from nn_model import nn_model
from planar_utils import *
from load_planar_dataset import load_planar_dataset

def predict(parameters, X):
    """
    Using the learned parameters, predicts a class for each example in X

    Arguments:
    parameters -- python dictionary containing your parameters
    X -- input data of size (n_x, m)

    Returns
    predictions -- vector of predictions of our model (red: 0 / blue: 1)
    """

    # Computes probabilities using forward propagation, and classifies to 0/1 using 0.5 as the threshold.
    ### START CODE HERE ### (≈ 2 lines of code)
    A2, cach2 = forward_propagation(X, parameters)
    predictions = (A2 > 0.5)
    ### END CODE HERE ###

    return predictions


'''
parameters, X_assess = predict_test_case()

predictions = predict(parameters, X_assess)
print("predictions mean = " + str(np.mean(predictions)))
'''


X, Y = load_planar_dataset()

'''
# Build a model with a n_h-dimensional hidden layer
parameters = nn_model(X, Y, n_h = 4, num_iterations = 10000, print_cost=True)

plt.ion()

# Plot the decision boundary
plot_decision_boundary(lambda x: predict(parameters, x.T), X, Y.flatten(400))
plt.title("Decision Boundary for hidden layer size " + str(4))



# Print accuracy
predictions = predict(parameters, X)
print ('Accuracy: %d' % float((np.dot(Y,predictions.T) + np.dot(1-Y,1-predictions.T))/float(Y.size)*100) + '%')

plt.ioff()
plt.show()
'''

plt.figure(figsize=(16, 32))
hidden_layer_sizes = [1, 2, 3, 4, 5, 20, 50]
for i, n_h in enumerate(hidden_layer_sizes):
    #plt.ion()
    plt.subplot(5, 2, i+1)
    plt.title('Hidden Layer of size %d' % n_h)
    parameters = nn_model(X, Y, n_h, num_iterations = 5000)
    plot_decision_boundary(lambda x: predict(parameters, x.T), X, Y.flatten(400))
    predictions = predict(parameters, X)
    accuracy = float((np.dot(Y,predictions.T) + np.dot(1-Y,1-predictions.T))/float(Y.size)*100)
    print ("Accuracy for {} hidden units: {} %".format(n_h, accuracy))
    #plt.ioff()
    plt.show()