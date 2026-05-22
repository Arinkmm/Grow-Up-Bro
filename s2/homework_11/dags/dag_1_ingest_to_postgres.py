import os
import csv
import json
import logging
from datetime import datetime
from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook

PG_CONN_ID = 'pg_growupbro_conn'
DATA_DIR = '/opt/airflow/dags/data'
JSON_PATH = os.path.join(DATA_DIR, 'care_events.json')
CSV_PATH = os.path.join(DATA_DIR, 'expert_advices.csv')

def ingest_json_events():
    if not os.path.exists(JSON_PATH):
        return

    with open(JSON_PATH, 'r', encoding='utf-8') as f:
        events = json.load(f)

    pg_hook = PostgresHook(postgres_conn_id=PG_CONN_ID)

    sql = """
          INSERT INTO main.plant_care_event (id, plant_id, event_type, created_at)
          VALUES (%s, %s, %s, %s)
              ON CONFLICT (id) DO NOTHING; \
          """

    counter = 0
    for item in events:
        pg_hook.run(sql, parameters=(
            item['id'],
            item['plant_id'],
            item['event_type'],
            item['created_at']
        ))
        counter += 1

def ingest_csv_advices():
    if not os.path.exists(CSV_PATH):
        return

    advices = []
    with open(CSV_PATH, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            row['rating'] = int(row['rating']) if row['rating'] else 0
            row['is_verified'] = row['is_verified'].lower() in ['true', '1', 't', 'yes']
            advices.append(row)

    pg_hook = PostgresHook(postgres_conn_id=PG_CONN_ID)

    sql = """
          INSERT INTO main.advice (tip_text, author, rating, is_verified)
          VALUES (%s, %s, %s, %s)
              ON CONFLICT DO NOTHING; \
          """

    for item in advices:
        pg_hook.run(sql, parameters=(
            item['tip_text'],
            item['author'],
            item['rating'],
            item['is_verified']
        ))

with DAG(
        dag_id="dag_1_file_data_ingestion",
        start_date=datetime(2026, 1, 1),
        schedule="@daily",
        catchup=False,
        tags=['ingestion', 'postgres', 'kfu_project']
) as dag:

    task_json = PythonOperator(
        task_id="process_json_events",
        python_callable=ingest_json_events
    )

    task_csv = PythonOperator(
        task_id="process_csv_advices",
        python_callable=ingest_csv_advices
    )

    [task_json, task_csv]