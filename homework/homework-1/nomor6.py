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

# Specify Astoria location ID
astoria_location_id = pd.read_sql_query(f"SELECT LocationID FROM {table_name} WHERE Zone = 'Astoria'", engine)['LocationID'][0]

# Query to get green taxi data
green_taxi_query = f"""
    SELECT *
    FROM {table_name}
    WHERE PULocationID = {astoria_location_id}
        AND EXTRACT(YEAR FROM lpep_pickup_datetime) = 2019
        AND EXTRACT(MONTH FROM lpep_pickup_datetime) = 9
"""

# Read green taxi data into a DataFrame
green_taxi_df = pd.read_sql_query(green_taxi_query, engine)

# Group by drop-off location and calculate total tip amount
dropoff_totals_df = green_taxi_df.groupby('DOLocationID')['tip_amount'].sum().reset_index()

# Query to get taxi zones data
taxi_zones_query = f"SELECT * FROM {table_name_taxi_zones}"

# Read taxi zones data into a DataFrame
taxi_zones_df = pd.read_sql_query(taxi_zones_query, engine)

# Find the drop-off zone with the largest total tip amount
max_tip_zone = dropoff_totals_df.merge(taxi_zones_df, left_on='DOLocationID', right_on='LocationID', how='inner')\
                                .nlargest(1, 'tip_amount')[['zone_name', 'tip_amount']]

print("Drop-off zone with the largest tip:")
print(max_tip_zone)
