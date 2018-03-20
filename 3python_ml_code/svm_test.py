from sklearn import svm
X = [[0, 0,4,5], [1, 1,2,3], [1, 2,2,3], [1, 1,3,3], [11, 1,21,3], [12, 12,2,23]]
y = [0, 1,1,1,2,2]
lin_clf = svm.LinearSVC()
print(lin_clf.fit(X, y) )

print(lin_clf.predict([[12,12,4,25]]) )