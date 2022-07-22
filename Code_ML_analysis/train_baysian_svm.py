import sys

import joblib
import numpy as np
import pandas as pd
from scipy.io import loadmat
from sklearn.model_selection import StratifiedKFold
from sklearn.base import clone
from skopt import BayesSearchCV
from skopt.space import Real 

from julearn import run_cross_validation
from julearn.utils import configure_logging
configure_logging(level='INFO')

base_dir = sys.argv[1]
save_dir = sys.argv[2]
sample = sys.argv[3]  # 'age' or 'age_TIV'
confounds = sys.argv[4]  # None or 'TIV'
confounds = None if confounds == 'None' else confounds


# load training data
df_train = pd.DataFrame(loadmat(
    f'{base_dir}/data/08_analysis_input/{sample}_matched_train_sample_80per_GMV.mat')['GMV']
    )

df_train['age'] = loadmat(
        f'{base_dir}/data/08_analysis_input/{sample}_matched_train_sample_80per_age.mat'
        )['age']

df_train['sex'] = loadmat(
    f'{base_dir}/data/08_analysis_input/{sample}_matched_train_sample_80per_sex_f1_m0.mat'
)['sex_f1_m0']

df_train['TIV'] = loadmat(
    f'{base_dir}/data/08_analysis_input/{sample}_matched_train_sample_80per_TIV.mat')['TIV']



df_train = df_train.rename(columns=lambda col: str(col))
df_train = df_train.astype('float64')


X = (df_train
        .drop(columns=['age', 'sex', 'TIV'])
        .columns.to_list()
)
y = 'sex'


# +
model_params = {

    'svm__C': (1., 1e8, 'log-uniform'), 
    'svm__gamma': (1e-7,1., 'log-uniform'), 
    'svm__kernel': ['rbf'],
    'pca__n_components': None,  # max as many components as sample size

    # After looking at the model from the paper these parameters seem to have been set:
    'svm__class_weight': 'balanced',
    'svm__probability': False, # for performance reason changed on refit

    # setting up search
    'search': BayesSearchCV,
    'search_params': {
    'n_iter': 250, 'n_jobs': 10,
    'n_points' : 1, 'pre_dispatch': '2*n_jobs',
        #'cv': StratifiedKFold(10)
        },
}

preprocess_X = (['pca'] if confounds is None else
                ['pca', 'remove_confound'])
# -
scores, model = run_cross_validation(
    X=X, y=y, confounds=confounds,
    data=df_train,
    model='svm', model_params=model_params,
    preprocess_X=preprocess_X, cv=StratifiedKFold(10),
    return_estimator='final', scoring=['accuracy'], n_jobs=10, verbose=1)
print('train: ', scores)


scores.to_csv(
    f'{save_dir}/scores_julearn__confound-{confounds}_sample-{sample}.csv')
joblib.dump(
        model, f'{save_dir}/model_julearn_confound-{confounds}_sample-{sample}')

refitted_model = (clone(model.best_estimator_)
                .set_params(svm__probability=True)
         )

X_used = X if confounds is None else X + [confounds]
refitted_model.fit(df_train[X_used], df_train[y])
joblib.dump(
    refitted_model, f'{save_dir}/refitted_model_julearn_confound-{confounds}_sample-{sample}')























