## Список всех ролей

```sql
SELECT rolname, rolcanlogin, rolsuper, rolcreatedb, rolcreaterole, rolinherit
FROM pg_roles
ORDER BY rolname;
```

![1.png](images/1.png)

## Проверка для ботаника

```sql
INSERT INTO main.plant (name) VALUES ('Тестовое растение');
```

![2.png](images/2.png)

## Проверка для менеджера

```sql
DELETE FROM main.plant WHERE id = 1;
```

![3.png](images/3.png)

## Проверка для агронома

```sql
SELECT * FROM main.advice;
```

![4.png](images/4.png)