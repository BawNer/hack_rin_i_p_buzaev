import keras as k
import pandas as pd
import numpy as np

data_frame = pd.read_csv('credit_score_ds.csv', sep='|')

input_names = [
    'age',
    'annual_income', 'monthly_inhand_salary',
    'num_bank_accounts', 'num_credit_card',
    'num_of_loan', 'num_credit_inquiries',
    'credit_history_age', 'amount_invested_monthly',
    'payment_behaviour',
    'monthly_balance',
]
output_names = ['credit_score']

raw_input_data = input_names
raw_output_data = output_names

max_age = 100
max_annual_income = data_frame['annual_income'].max()
max_monthly_inhand_salary = data_frame['monthly_inhand_salary'].max()
max_num_bank_accounts = data_frame['monthly_inhand_salary'].max()
max_num_credit_card = data_frame['num_credit_card'].max()
max_num_of_loan = data_frame['num_of_loan'].max()
max_num_credit_inquiries = data_frame['num_credit_inquiries'].max()
max_credit_history_age = data_frame['credit_history_age'].max()
max_amount_invested_monthly = data_frame['amount_invested_monthly'].max()
max_monthly_balance = data_frame['monthly_balance'].max()


encoders = {
    'age': lambda age: [age/max_age],
    'annual_income': lambda annual_income: [annual_income/max_annual_income],
    'monthly_inhand_salary': lambda monthly_inhand_salary: [monthly_inhand_salary/max_monthly_inhand_salary],
    'num_bank_accounts': lambda num_bank_accounts: [num_bank_accounts/max_num_bank_accounts],
    'num_credit_card': lambda num_credit_card: [num_credit_card/max_num_credit_card],
    'num_of_loan': lambda num_of_loan: [num_of_loan/max_num_of_loan],
    'num_credit_inquiries': lambda num_credit_inquiries: [num_credit_inquiries/max_num_credit_inquiries],
    'credit_history_age': lambda credit_history_age: [credit_history_age/max_credit_history_age],
    'amount_invested_monthly': lambda amount_invested_monthly: [amount_invested_monthly/max_amount_invested_monthly],
    'monthly_balance': lambda monthly_balance: [monthly_balance/max_monthly_balance],
    'payment_behaviour': lambda payment_behaviour: {
        'High_spent_Small_value_payments': [0, 0, 1, 0, 0, 0],
        'Low_spent_Large_value_payments': [0, 0, 0, 1, 0, 0],
        'Low_spent_Medium_value_payments': [0, 0, 0, 0, 1, 0],
        'Low_spent_Small_value_payments': [0, 0, 0, 0, 0, 1],
        'High_spent_Medium_value_payments': [0, 1, 0, 0, 0, 0],
        'High_spent_Large_value_payments': [1, 0, 0, 0, 0, 0]
    }.get(payment_behaviour),
    'credit_score': lambda s_value: [s_value]
}


def dataframe_to_dict(df):
    result = dict()
    for column in df.columns:
        values = data_frame[column].values
        result[column] = values
    return result


def make_supervised(df):
    raw_input_data = data_frame[input_names]
    raw_output_data = data_frame[output_names]
    return {'inputs': dataframe_to_dict(raw_input_data),
            'outputs': dataframe_to_dict(raw_output_data)}


def encode(data):
    vectors = []
    for data_name, data_values in data.items():
        encoded = list(map(encoders[data_name], data_values))
        vectors.append(encoded)
    formatted = []
    for vector_raw in list(zip(*vectors)):
        vector = []
        for element in vector_raw:
            for e in element:
                vector.append(e)
        formatted.append(vector)
    return formatted

supervised = make_supervised(data_frame)
encoded_inputs = np.array(encode(supervised['inputs']))
encoded_outputs = np.array(encode(supervised['outputs']))

train_x = encoded_inputs[:20000]
train_y = encoded_outputs[:20000]

test_x = encoded_inputs[20000:]


try:
    model = k.models.load_model('model_train.h5')
except (OSError, IOError):
    model = k.Sequential()
    model.add(k.layers.Dense(units=256, activation='relu'))
    model.add(k.layers.Dense(units=128, activation='relu'))
    model.add(k.layers.Dense(units=64, activation='relu'))
    model.add(k.layers.Dense(units=32, activation='relu'))
    model.add(k.layers.Dense(units=1, activation='sigmoid'))

    model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])
    fit_results = model.fit(x=train_x, y=train_y, epochs=200, validation_split=0.2)

    model.save('model_train.h5')

predicted_test = model.predict(test_x)

real_data = data_frame.iloc[20000:][input_names+output_names]
real_data['predicted_score'] = predicted_test


