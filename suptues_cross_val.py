import pandas as pd
import numpy as np
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import cross_val_score, KFold

# load the data in
df = pd.read_csv('suptues.csv')
df = df.drop("Unnamed: 0", axis = 1) # remove this column
df.head()

# classify the haley_vote variable to > .5
df[df['haley_vote'] > .5].count() # there are 91 places where Nikki Haley got the majority of the vote

# make our variables
x = np.array(df[['percent_ba_plus']])
y = np.array(df['haley_vote'].apply(lambda x: 1 if x > .5 else 0))

# kfold validation
kf = KFold(n_splits = 10, shuffle = True, random_state = 123)
logreg = LogisticRegression()

# cross validation results
cv_results = cross_val_score(logreg, x, y, cv = kf)
print('K-Fold Cross-Validation Mean: {:.2f}'.format(np.mean(cv_results)))