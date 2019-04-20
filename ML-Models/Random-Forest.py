import pandas as pd
from sklearn.externals import joblib
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier


df = pd.read_csv('DataSet.csv')

columns = ['OPEN','CLOSE','HIGH','LOW','VOLUME','MA', 'STO', 'FIBO', 'AC', 'BUL', 'ICCI', 'MACD', 'RSI','BEAR','AD','ATR','AO','MOM','OSMA']
labels = df['MARKET'].values
features = df[list(columns)].values

X_train, X_test, y_train, y_test = train_test_split(features, labels, test_size=0.1)


clf = RandomForestClassifier(n_estimators=5)
clf = clf.fit(X_train, y_train)
accuracy = clf.score(X_train, y_train)
print (' traning data accuracy ', accuracy*100)

accuracy = clf.score(X_test, y_test)
print (' testing data accuracy ', accuracy*100)

# Output a pickle file for the model
joblib.dump(clf, 'saved_model.pkl')
