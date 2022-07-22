import sys

import joblib
import pandas as pd
import numpy as np 
from scipy.io import loadmat
from sklearn.base import clone
from sklearn.calibration import CalibratedClassifierCV
np.random.seed(231495)

base_dir = sys.argv[1]
save_dir = base_dir + '/derivatives'

for confounds in [None, 'TIV']:
    for sample in ['age', 'age_TIV']:

        model = joblib.load(
            f'{base_dir}/derivatives/model_julearn_confound-{confounds}_sample-{sample}'
        ).best_estimator_

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

        drop = (['age', 'sex'] if confounds == 'TIV'
                else ['age', 'sex', 'TIV']
                )
        X = (df_train
             .drop(columns=drop)
             )
        y = df_train['sex']

        X_prep, *_ = model.preprocess(X, y)
        svm_only = model['svm']

        model_calibrated = CalibratedClassifierCV(
            base_estimator=svm_only, cv="prefit")
        model_calibrated.fit(X_prep, y)

        joblib.dump(
            model_calibrated,
            f'{save_dir}/calibrated_refitted_model_julearn_confound-{confounds}_sample-{sample}'
        )
