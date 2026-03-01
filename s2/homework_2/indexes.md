## =

```sql
EXPLAIN (ANALYZE) SELECT * FROM main. plant WHERE name = 'Pacтeниe Тип-150000';

EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM main. plant WHERE name = 'Pacтeниe Тuп-150000';
```
### Без индексов

![1.1_without_index.png](images/1.1_without_index.png)
![1.2_without_index.png](images/1.2_without_index.png)

### C b-tree индексом

![1.1_btree_index.png](images/1.1_btree_index.png)
![1.2_btree_index.png](images/1.2_btree_index.png)

### С hash индексом

![1.1_hash_index.png](images/1.1_hash_index.png)
![1.2_hash_index.png](images/1.2_hash_index.png)

## >

```sql
EXPLAIN (ANALYZE) SELECT * FROM main.plant WHERE sunlight_id > 3;

EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM main.plant WHERE sunlight_id > 3;
```
### Без индексов

![2.1_without_index.png](images/2.1_without_index.png)
![2.2_without_index.png](images/2.2_without_index.png)

### C b-tree индексом

![2.1_btree_index.png](images/2.1_btree_index.png)
![2.2_btree_index.png](images/2.2_btree_index.png)

### С hash индексом

Не поддерживается

## <

```sql
EXPLAIN (ANALYZE) SELECT * FROM main.plant WHERE watering_id < 3;

EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM main.plant WHERE watering_id < 3;
```
### Без индексов

![3.1_without_index.png](images/3.1_without_index.png)
![3.2_without_index.png](images/3.2_without_index.png)

### C b-tree индексом

![3.1_btree_index.png](images/3.1_btree_index.png)
![3.2_btree_index.png](images/3.2_btree_index.png)

### С hash индексом

Не поддерживается

## %LIKE

```sql
EXPLAIN (ANALYZE) SELECT * FROM main.plant WHERE name LIKE '%35';

EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM main.plant WHERE name LIKE '%35';
```
### Без индексов

![4.1_without_index.png](images/4.1_without_index.png)
![4.2_without_index.png](images/4.2_without_index.png)

### C b-tree индексом

Не поддерживается

### С hash индексом

Не поддерживается

## LIKE%

```sql
EXPLAIN (ANALYZE) SELECT * FROM main.plant WHERE name LIKE 'Pacтeниe Tип-1%';

EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM main.plant WHERE name LIKE 'Pacтeниe Tип-1%';
```
### Без индексов

![5.1_without_index.png](images/5.1_without_index.png)
![5.2_without_index.png](images/5.2_without_index.png)

### C b-tree индексом (само выбрало не использовать индексы, связано с тем, что около 44% всех записей в бд, это то что мы ищем и это дольше, чем простой поиск)

![5.1_btree_index.png](images/5.1_btree_index.png)
![5.2_btree_index.png](images/5.2_btree_index.png)

### С hash индексом

Не поддерживается

## IN

```sql
EXPLAIN (ANALYZE) SELECT * FROM main.plant WHERE sunlight_id IN (2,3,4);

EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM main.plant WHERE sunlight_id IN (2,3,4);
```
### Без индексов

![6.1_without_index.png](images/6.1_without_index.png)
![6.2_without_index.png](images/6.2_without_index.png)

### C b-tree индексом

![6.1_btree_index.png](images/6.1_btree_index.png)
![6.2_btree_index.png](images/6.2_btree_index.png)

### С hash индексом

![6.1_hash_index.png](images/6.1_hash_index.png)
![6.2_hash_index.png](images/6.2_hash_index.png)

## Составной индекс

```sql
EXPLAIN (ANALYZE) SELECT * FROM main.plant WHERE watering_id = 3 AND fertilizer_id > 4000;

EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM main.plant WHERE watering_id = 3 AND fertilizer_id > 4000;
```
### Без индексов

![7.1_without_index.png](images/7.1_without_index.png)
![7.2_without_index.png](images/7.2_without_index.png)

### C индексом

![7.1_complex_index.png](images/7.1_complex_index.png)
![7.2_complex_index.png](images/7.2_complex_index.png)
