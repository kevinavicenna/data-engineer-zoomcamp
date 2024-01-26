import pandas as pd
from sqlalchemy import create_engine

# Your PostgreSQL connection details
user = 'Kevin'
password = 'inipasswordadmin99'
host = 'localhost'
port = '5432'
db = 'green_ny_taxi'
table_name = 'green_taxi_data'

engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

# Specify the target dates
target_dates = ['2019-09-18', '2019-09-16', '2019-09-26', '2019-09-21']

# Read data for the specified dates
query = f"SELECT * FROM {table_name} WHERE DATE(lpep_pickup_datetime) IN {tuple(target_dates)}"
df = pd.read_sql_query(query, engine)

# Convert 'lpep_pickup_datetime' to datetime format
df['lpep_pickup_datetime'] = pd.to_datetime(df['lpep_pickup_datetime'])

# Group by pick-up day and calculate total trip distance
result = df.groupby(df['lpep_pickup_datetime'].dt.date)['trip_distance'].sum().reset_index()
result = result.rename(columns={'lpep_pickup_datetime': 'pickup_day'})

# Find the day with the largest total trip distance
max_distance_day = result.loc[result['trip_distance'].idxmax()]

print("Pick-up day with the largest trip distance:")
print(max_distance_day[['pickup_day', 'trip_distance']])
