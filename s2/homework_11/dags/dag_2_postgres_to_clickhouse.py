import logging
from datetime import datetime
from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
import clickhouse_connect

PG_CONN_ID = 'pg_growupbro_conn'
CH_HOST = 'clickhouse'
CH_USER = 'default'
CH_PASS = '08122006Ar'

def extract_all():
    pg_hook = PostgresHook(postgres_conn_id=PG_CONN_ID)
    events = pg_hook.get_records("SELECT id, plant_id, event_type, created_at::text FROM main.plant_care_event;")
    advices = pg_hook.get_records("SELECT * FROM main.advice;")
    return {"events": events, "advices": advices}

def load_all_to_clickhouse(ti):
    data = ti.xcom_pull(task_ids='extract_data')
    client = clickhouse_connect.get_client(host=CH_HOST, username=CH_USER, password=CH_PASS)

    if data["events"]:
        prepared_events = [[r[0], r[1], r[2], datetime.strptime(r[3][:19], '%Y-%m-%d %H:%M:%S')] for r in data["events"]]
        client.insert(table='olap.src_plant_care_events', data=prepared_events,
                      column_names=['id', 'plant_id', 'event_type', 'created_at'])

    if data["advices"]:
        client.insert(table='olap.src_advice', data=data["advices"],
                      column_names=['id', 'tip_text', 'author', 'rating', 'is_verified'])

with DAG(dag_id="dag_2_to_clickhouse", start_date=datetime(2026, 1, 1), schedule="@daily", catchup=False) as dag:
    extract = PythonOperator(task_id="extract_data", python_callable=extract_all)
    load = PythonOperator(task_id="load_data_to_ch", python_callable=load_all_to_clickhouse)
    extract >> load