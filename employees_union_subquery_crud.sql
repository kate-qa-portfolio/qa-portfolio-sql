/* =========================================================
1. Таблиці JOB_HISTORY, EMPLOYEES                   Оператор UNION
Напишіть запит в якому будуть відображатися поля ідентифікатор співробітника, 
дата найму та дата звільнення. Якщо співробітник досі працює в компанії 
дата звільнення має бути null.
=========================================================*/
SELECT employee_id, hire_date, null as end_date, job_id
FROM HR.employees
UNION
SELECT employee_id, start_date, end_date, job_id
FROM HR.job_history;
/* =========================================================
2. Таблиці JOB_HISTORY, EMPLOYEES                    Оператор UNION
Напишіть запит в якому буде відображатися статус співробітника (status)
із варіантами заповнення current_employees – якщо співробітник досі працює
в компанії і fired_emloyees – якщо співробітник звільнився та кількість 
співробітників за кожним із цих статусів
=========================================================*/
SELECT status, COUNT(employee_id)
FROM (SELECT employee_id, 'current_employees' AS status
    FROM hr.employees
    UNION ALL
    SELECT employee_id, 'fired_employees' AS status
    FROM hr.job_history)
GROUP BY status;
/* =========================================================
3. Таблиці JOB_HISTORY, EMPLOYEES                      Оператор UNION
Напишіть запит в якому буде відображатися статус співробітника (status)
 із варіантами заповнення current_employees – якщо співробітник досі працює 
 в компанії і fired_emloyees – якщо співробітник звільнився та кількість співробітників 
 за кожним із цих статусів групуючи ці показники за ідентифікатором посади.
=========================================================*/
SELECT job_id, status,
COUNT(employee_id) AS employee_count
FROM (SELECT employee_id, job_id, 'current_employees' AS status
    FROM hr.employees
    UNION ALL
    SELECT employee_id, job_id, 'fired_employees' AS status
    FROM hr.job_history)
GROUP BY job_id, status;
/* =========================================================
4. Таблиці JOB_HISTORY, EMPLOYEES.                      SUBQUERY
Напишіть запит в якому буде відображатися за зменшенням кількість співробітників
 за кожним департаментом, лише серед тих департаментів, де було звільнено більше 1 співробітника.
=========================================================*/
SELECT department_id, COUNT(employee_id) AS employee_count
FROM HR.employees
WHERE department_id IN (SELECT department_id
   				 FROM HR.job_history
  				  GROUP BY department_id
   				 HAVING COUNT(employee_id) > 1)
GROUP BY department_id
ORDER BY employee_count DESC;
/* =========================================================
5. Таблиці JOB_HISTORY, EMPLOYEES.                      SUBQUERY
Напишіть запит в якому буде відображатися ідентифікатори співробітників,
імена, прізвища тільки із тих департаментів, де є співробітники, які працювали менше року
=========================================================*/
SELECT EMPLOYEE_ID, last_name, first_name
FROM HR.EMPLOYEES
WHERE department_id IN (SELECT department_id
   				 FROM HR.job_history
    				 WHERE (END_DATE - START_DATE)/ 365 < 1);
/* =========================================================
6. Таблиці JOB_HISTORY, EMPLOYEES.                       SUBQUERY
Напишіть запит в якому буде відображатися ідентифікатори співробітників, імена, 
прізвища тільки за умови, якщо в цьому департаменті є співробітники, які пропрацювали більше року
=========================================================*/
SELECT EMPLOYEE_ID, last_name, first_name
FROM HR.EMPLOYEES
WHERE department_id IN (SELECT department_id
   				 FROM HR.job_history
     				WHERE (END_DATE - START_DATE)/ 365 > 1);

/* =========================================================
7. Таблиці JOB_HISTORY, EMPLOYEES.                          SUBQUERY
Напишіть запит в якому буде відображатися кількість співробітників за кожним 
із департаментів тільки за умови, якщо в цьому департаменті є співробітники, які 
пропрацювали більше року. Відсортуйте всі записи за зменшенням кількості співробітників.
=========================================================*/
SELECT department_id, COUNT(*) AS employee_count
FROM HR.EMPLOYEES
WHERE department_id IN (SELECT department_id
    				FROM HR.job_history
   	 			WHERE (END_DATE - START_DATE)/ 365 > 1)
GROUP BY department_id
ORDER BY employee_count DESC;
/* =========================================================
8. Таблиця EMPLOYEES
Напишіть скрипт, який має додавати запис у таблицю із вашим іменем і прізвищем. 
Дата найму завжди має бути сьогоднішнім числом, зп = 25000, департамент = 110, 
менеджер 205. Інші поля можуть бути заповнені довільно.
=========================================================*/
INSERT INTO HR.employees
(EMPLOYEE_ID, FIRST_NAME, LAST_NAME,
EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY,
COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID)
VALUES ((SELECT MAX(employee_id) + 1 FROM HR.employees), 'Kateryna', 'Cherednichenko',
'bfjgjjf@gmail.com', '123456789', SYSDATE, 'IT_PROG', 25000,
NULL, 205, 110);
/* =========================================================
9. Таблиця EMPLOYEES.
Напишіть скрипт, який має оновлювати створений вище запис у таблиці із вашим 
іменем і прізвищем. Змініть у цьому записі департамент на 90, а ЗП на 30000.
=========================================================*/
UPDATE HR.employees
SET DEPARTMENT_ID = 90, SALARY = 30000
WHERE employee_id = 207;
/* =========================================================
10. Таблиця EMPLOYEES
Напишіть скрипт, який має видаляти створений вами запис у таблиці.
=========================================================*/
DELETE FROM HR.employees
WHERE employee_id = 207;

