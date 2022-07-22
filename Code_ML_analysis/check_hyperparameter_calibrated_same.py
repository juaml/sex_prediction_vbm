import joblib

base_dir = '../derivatives/'

for sample in ['age', 'age_TIV']:
    for confound in [None, 'TIV']:
        model_name = f'model_julearn_confound-{confound}_sample-{sample}'
        model_calibrated_params = joblib.load(
                f'{base_dir}calibrated_refitted_{model_name}'
                ).base_estimator.get_params()
        model_params = joblib.load(
                f'{base_dir}{model_name}').best_estimator_['svm'].get_params()
        print(f'Check: {sample = }, {confound = }')
        for param in ['C', 'gamma']:
            assert model_calibrated_params[param] == model_params[param]
            print(param, ' = ', model_calibrated_params[param])

