# GRADED FUNCTION: L_layer_model


import time
import numpy as np
import h5py
import matplotlib.pyplot as plt
import scipy
from PIL import Image
from scipy import ndimage
from dnn_app_utils_v2 import predict, load_data


import sys
sys.path.append(r"/home/luguorui/PycharmProjects/course1_week4")
from Initialization.initialize_parameters_deep import initialize_parameters_deep
from Forward_propagation_module.L_model_forward import L_model_forward
from Cost_function.compute_cost import compute_cost
from Backward_propagation_module.L_model_backward import L_model_backward
from Backward_propagation_module.update_parameters import update_parameters


### CONSTANTS ###
layers_dims = [12288, 20, 7, 5, 1] #  5-layer model



def L_layer_model(X, Y, layers_dims, learning_rate = 0.0075, num_iterations = 3000, print_cost=False):#lr was 0.009
    """
    Implements a L-layer neural network: [LINEAR->RELU]*(L-1)->LINEAR->SIGMOID.

    Arguments:
    X -- data, numpy array of shape (number of examples, num_px * num_px * 3)
    Y -- true "label" vector (containing 0 if cat, 1 if non-cat), of shape (1, number of examples)
    layers_dims -- list containing the input size and each layer size, of length (number of layers + 1).
    learning_rate -- learning rate of the gradient descent update rule
    num_iterations -- number of iterations of the optimization loop
    print_cost -- if True, it prints the cost every 100 steps

    Returns:
    parameters -- parameters learnt by the model. They can then be used to predict.
    """

    np.random.seed(1)
    costs = []                         # keep track of cost

    # Parameters initialization.
    ### START CODE HERE ###
    parameters = initialize_parameters_deep(layers_dims)
    ### END CODE HERE ###

    # Loop (gradient descent)
    for i in range(0, num_iterations):

        # Forward propagation: [LINEAR -> RELU]*(L-1) -> LINEAR -> SIGMOID.
        ### START CODE HERE ### (≈ 1 line of code)
        AL, caches = L_model_forward(X, parameters)
        ### END CODE HERE ###

        # Compute cost.
        ### START CODE HERE ### (≈ 1 line of code)
        cost = compute_cost(AL, Y)
        ### END CODE HERE ###

        # Backward propagation.
        ### START CODE HERE ### (≈ 1 line of code)
        grads = L_model_backward(AL, Y, caches)
        ### END CODE HERE ###

        # Update parameters.
        ### START CODE HERE ### (≈ 1 line of code)
        parameters = update_parameters(parameters, grads, learning_rate)
        ### END CODE HERE ###

        # Print the cost every 100 training example
        if print_cost and i % 100 == 0:
            print("Cost after iteration %i: %f" % (i, cost))
        if print_cost and i % 100 == 0:
            costs.append(cost)

    # plot the cost
    plt.plot(np.squeeze(costs))
    plt.ylabel('cost')
    plt.xlabel('iterations (per tens)')
    plt.title("Learning rate =" + str(learning_rate))
    plt.show()

    return parameters

'''
train_x_orig, train_y, test_x_orig, test_y, classes = load_data()
m_train = train_x_orig.shape[0]
num_px = train_x_orig.shape[1]
m_test = test_x_orig.shape[0]
train_x_flatten = train_x_orig.reshape(train_x_orig.shape[0], -1).T   # The "-1" makes reshape flatten the remaining dimensions
test_x_flatten = test_x_orig.reshape(test_x_orig.shape[0], -1).T
train_x = train_x_flatten/255.
test_x = test_x_flatten/255.
'''


train_x, train_y = [], []
for item in open("/home/luguorui/PycharmProjects/course1_week4/UCI.txt"):
    tem = [0] * 30
    it = item.split()
    for i in range(1, 31):
        tem[i - 1] = float(it[i])
    train_x.append(tem)
    if it[0] == "M":
        train_y.append(1)
    else:
        train_y.append(0)
train_x = np.array(train_x)
train_y = np.array(train_y)
train_x = train_x.T
train_y = train_y.reshape(1, len(train_y))
print(train_x.shape, train_y.shape)


L = (len(train_x),5,7, len(train_y))

parameters = L_layer_model(train_x, train_y, L, num_iterations = 11000, print_cost = True)
predictions_train = predict(train_x, train_y, parameters)