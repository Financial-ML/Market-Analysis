import pandas as pd
import os
from sklearn.externals import joblib
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report


df = pd.read_csv('DataSet.csv')

exists = os.path.isfile('saved_model.pkl')
if exists:
    os.remove('saved_model.pkl')

columns = ['OPEN','CLOSE','HIGH','LOW','VOLUME','MA', 'STO', 'FIBO', 'AC', 'BUL', 'ICCI', 'MACD', 'RSI','BEAR','AD','ATR','AO','MOM','OSMA']
labels = df['MARKET'].values
features = df[list(columns)].values

X_train, X_test, y_train, y_test = train_test_split(features, labels, test_size=0.5)
clf = RandomForestClassifier(n_estimators=5)
clf = clf.fit(X_train, y_train)

accuracy = clf.score(X_train, y_train)
print (' Traning Data accuracy ', accuracy*100)

accuracy = clf.score(X_test, y_test)
print (' Testing Data accuracy ', accuracy*100)

ypredict = clf.predict(X_train)
print ('\n Training classification report\n', classification_report(y_train, ypredict))

ypredict = clf.predict(X_test)
print ('\n Testing classification report\n', classification_report(y_test, ypredict))

# Output a pickle file for the model
joblib.dump(clf, 'saved_model.pkl')
