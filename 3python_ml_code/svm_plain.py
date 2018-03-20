import numpy as np
import matplotlib.pyplot as plt
from sklearn import svm

my_data = np.genfromtxt('2018317test_data_1.csv', delimiter=',')

X = my_data[1:, 4:] #skip first row, skip first four columns
print("X",X,"X")

y = my_data[1:, 2] #skip first row, get third column
print("y",y,"y")

n_sample = len(X)

#randomize data
np.random.seed(0)
order = np.random.permutation(n_sample)
X = X[order]
y = y[order].astype(np.float)

#separate into training and testing
X_train = X[:int(.9 * n_sample)]
y_train = y[:int(.9 * n_sample)]
X_test = X[int(.9 * n_sample):]
y_test = y[int(.9 * n_sample):]

# fit the model
for fig_num, kernel in enumerate(('linear', 'rbf')):
    print(fig_num)
    clf = svm.SVC(kernel=kernel, gamma=10)
    clf.fit(X_train, y_train)

    plt.figure(fig_num)
    plt.clf()
    plt.scatter(X[:, 0], X[:, 1], c=y, zorder=10, cmap=plt.cm.Paired,
                edgecolor='k', s=40)

    # Circle out the test data
    plt.scatter(X_test[:, 0], X_test[:, 1], s=80, facecolors='none',
                zorder=10, edgecolor='k')

    plt.axis('tight')
    x_min = X[:, 0].min()
    x_max = X[:, 0].max()
    y_min = X[:, 1].min()
    y_max = X[:, 1].max()

    plt.title(kernel)
plt.show()
