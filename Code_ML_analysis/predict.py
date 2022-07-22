from pathlib import Path
import joblib
import pandas as pd
from scipy.io import loadmat

#no overlap sqamples 
base_dir_age =  "../data/08_analysis_input/age_matched_test_sample_20_per_"
base_dir_ageTIV = "../data/08_analysis_input/age_TIV_matched_test_sample_20_per_" 

base_dir_aachen = "../data/Code_Create_transgender_input_Aachen_LW/04_model_input/model_input_"
base_dir_barcelona = "../data/Code_Create_transgender_input_Barcelona_LW/04_model_input/model_input_"

base_save_dir = '../derivatives/predictions/'
Path(base_save_dir).mkdir(exist_ok=True, parents=True)
base_model_dir = '../derivatives/'


# load in the refitted models
models_confound_none = {}
models_confound_TIV = {}

models_confound_none['age'] = joblib.load(
    base_model_dir + 'refitted_model_julearn_confound-None_sample-age')

models_confound_none['age_TIV'] = joblib.load(
    base_model_dir + 'refitted_model_julearn_confound-None_sample-age_TIV')

models_confound_TIV['age']= joblib.load(
        base_model_dir + 'refitted_model_julearn_confound-TIV_sample-age')
models_confound_TIV['age_TIV'] = joblib.load(
        base_model_dir + 'refitted_model_julearn_confound-TIV_sample-age_TIV')

models_dict = {None:models_confound_none, 'TIV': models_confound_TIV}

def save_predictions(data, name):
    for sample in ['age', 'age_TIV']:
        for conf in [None, 'TIV']:
            col_to_drop = ['Sex', 'TIV'] if conf is None else ['Sex']
            df_val = data.copy().drop(columns=col_to_drop)
            df_predictions = pd.DataFrame()
            model = models_dict[conf][sample]
            df_predictions['pred'] = model.predict(df_val)
            df_predictions[['pred_proba_0', 'pred_proba_1']] = model.predict_proba(df_val)
            df_predictions.to_csv(
                    f'{base_save_dir}{name}_predictions_model_trained_on_confound-{conf}_sample-{sample}.txt',
                    index=False)


# load in validation data for age matched
df_val_age = pd.DataFrame(loadmat(base_dir_age +
                            'GMV.mat')['GMV'])
df_val_age = (df_val_age
               .rename(columns=lambda col: str(col))
               .astype('float64')
         )
df_val_age['Sex'] = loadmat(base_dir_age + 'sex_f1_m0.mat')['sex_f1_m0']
df_val_age['TIV'] = loadmat(base_dir_age + 'TIV.mat')['TIV']

# predict for age 

save_predictions(df_val_age, 'val-age')

# load in validation data for ageTIV matched

df_val_ageTIV = pd.DataFrame(loadmat(base_dir_ageTIV +
                    'GMV.mat')['GMV'])
df_val_ageTIV = (df_val_ageTIV
                   .rename(columns=lambda col: str(col))
                   .astype('float64')
         )
df_val_ageTIV['Sex'] = loadmat(base_dir_ageTIV +
                         'sex_f1_m0.mat')['sex_f1_m0']

df_val_ageTIV['TIV'] = loadmat(base_dir_ageTIV +
                         'TIV.mat')['TIV']

# save predictions for age_TIV 


save_predictions(df_val_ageTIV, 'val-ageTIV')


# load in Aachen
df_aachen = pd.DataFrame(loadmat(base_dir_aachen + 
                        'GMV.mat')['GMV']
    )
df_aachen.rename(columns=lambda col: str(col), inplace=True)
df_aachen['Sex'] = loadmat(base_dir_aachen + 
                         'sex_f1_m0.mat')['sex_f1_m0']
df_aachen['TIV'] = loadmat(base_dir_aachen + 
                         'TIV.mat')['TIV']

# predictions for Aachen
save_predictions(df_aachen, 'aachen')

# load in Barcelona

df_barcelona  = pd.DataFrame(loadmat(base_dir_barcelona  + 
                        'GMV.mat')['GMV']
    )
df_barcelona.rename(columns=lambda col: str(col), inplace=True)
df_barcelona['Sex'] = loadmat(base_dir_barcelona + 
                         'sex_f1_m0.mat')['sex_f1_m0']
df_barcelona ['TIV'] = loadmat(base_dir_barcelona + 
                         'TIV.mat')['TIV']

# predictions for barcelona 

save_predictions(df_barcelona, 'barcelona')


