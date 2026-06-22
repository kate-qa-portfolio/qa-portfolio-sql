/* =========================================================
1. Таблиця DEPARTMENTS.
Застосовуючи оператор CASE напишіть скрипт, який буде виводити список назв
 департаментів та нове поле “State”, яке буде заповнюватися в залежності від того, 
яке значення має поле LOCATION_ID.
Для LOCATION_ID 1700 нове поле “State” має містити запис “Washington”,
Для 1400 – “Texas”
Для 1500 і 2500 – “California”
Для 1800 – “ Ontario”
2400 – “Other”
2700 – “Bavaria”
=========================================================*/

SELECT DEPARTMENT_NAME,  
CASE
WHEN LOCATION_ID = 1700 THEN 'Washington'
WHEN LOCATION_ID = 1400 THEN 'Texas'
WHEN LOCATION_ID IN (1500, 2500) THEN 'California'
WHEN LOCATION_ID = 1800 THEN 'Ontario'
WHEN LOCATION_ID = 2400 THEN 'Other'
WHEN LOCATION_ID = 2700 THEN 'Bavaria'
END AS State
FROM hr.DEPARTMENTS ;
/* =========================================================
2. Таблиця LOCATIONS.
Напишіть запит для відображення інформації про кількість локацій компанії у
кожному COUNTRY_ID та відсортуйте список від країни із найбільшою кількістю локацій компанії.
=========================================================*/

SELECT country_id,
COUNT (location_id) AS total_locations
FROM hr.LOCATIONS
group by country_id
Order by total_locations DESC;
/* =========================================================
3. Таблиця LOCATIONS.
Напишіть запит для відображення інформації про кількість локацій компанії у
кожному COUNTRY_ID, вивівши інформацію тільки по країнам, де кількість локацій більше двох
=========================================================*/

SELECT country_id,
COUNT(location_id) AS total_locations
FROM hr.locations
GROUP BY country_id
HAVING COUNT(location_id) > 2;
/* =========================================================
4. Таблиці LOCATIONS та COUNTRIES.
Напишіть запит для відображення всіх значень полів STREET_ADDRESS,
STATE_PROVINCE та COUNTRY_NAME та відсортуйте за алфавітом (від A до Z) назву країн.
=========================================================*/

SELECT hr.locations.street_address, hr.locations.state_province, hr.countries.country_name
FROM hr.locations
JOIN hr.countries ON hr.locations.country_id = hr.countries.country_id
ORDER BY country_name ASC;
/* =========================================================
5. Таблиці LOCATIONS та COUNTRIES.
Напишіть запит для розрахунку кількості STREET_ADDRESS за кожною із COUNTRY_NAME,
які мають відповідні значення в обох таблицях. Виведіть всі показники.
=========================================================*/

SELECT hr.countries.country_name,
COUNT (street_address) AS total_address
FROM hr.locations
INNER JOIN hr.countries ON hr.locations.country_id = hr.countries.country_id
GROUP BY hr.countries.country_name;
/* =========================================================
6. Таблиці LOCATIONS, COUNTRIES, REGIONS.
Напишіть запит для відображення всіх значень полів, STATE_PROVINCE та COUNTRY_NAME, REGION_NAME.
=========================================================*/

SELECT l.state_province, c.country_name, r.region_name
FROM hr.locations l
JOIN hr.countries c ON l.country_id = c.country_id
JOIN hr.regions r ON c.region_id = r.region_id;

SELECT l.state_province, c.country_name, r.region_name
FROM hr.locations l, hr.countries c, hr.regions r
WHERE l.country_id = c.country_id
AND c.region_id = r.region_id;
/* =========================================================
7. Таблиці LOCATIONS, COUNTRIES, REGIONS.
Напишіть запит для розрахунку кількості STREET_ADDRESS кількості COUNTRY_NAME для кожного REGION_NAME,
які мають відповідні значення в усіх трьох таблицях. Виведіть усі показники.
=========================================================*/

SELECT r.region_name,
COUNT(l.street_address) AS count_street_address,
COUNT(c.country_name) AS count_country_name
FROM hr.locations l
JOIN hr.countries c ON l.country_id = c.country_id
JOIN hr.regions r ON c.region_id = r.region_id
GROUP BY r.region_name;
/* =========================================================
8. Таблиці LOCATIONS, COUNTRIES, REGIONS.
Напишіть запит для розрахунку кількості STREET_ADDRESS, кількості COUNTRY_NAME 
для кожного REGION_NAME, які мають відповідні значення в усіх трьох таблицях.
Виведіть усі показники. Напишіть скрипт використовуючи аліаси для назв таблиць.
=========================================================*/

SELECT r.region_name,
COUNT(l.street_address) AS count_street_address,
COUNT(c.country_name) AS count_country_name
FROM hr.locations l
JOIN hr.countries c ON l.country_id = c.country_id
JOIN hr.regions r ON c.region_id = r.region_id
GROUP BY r.region_name;
/* =========================================================
9. Таблиці LOCATIONS, COUNTRIES, REGIONS.
Напишіть запит для розрахунку кількості STREET_ADDRESS кількості 
COUNTRY_NAME для кожного REGION_NAME, які мають відповідні значення в усіх трьох таблицях.
Та виведіть ті REGION_NAME, де кількість COUNTRY_NAME буде більше 6.
=========================================================*/

SELECT r.region_name,
COUNT(l.street_address) AS count_street_address,
COUNT(c.country_name) AS count_country_name
FROM hr.locations l
JOIN hr.countries c ON l.country_id = c.country_id
JOIN hr.regions r ON c.region_id = r.region_id
GROUP BY r.region_name
HAVING COUNT(c.country_name) > 6;
/* =========================================================
10. Таблиці LOCATIONS, COUNTRIES, REGIONS.
Напишіть запит для розрахунку кількості STREET_ADDRESS кількості COUNTRY_NAME 
для кожного REGION_NAME, які мають відповідні значення в усіх трьох таблицях. 
Та виведіть ті REGION_NAME, де кількість COUNTRY_NAME буде більше 6.
 Виведіть всі показники. Напишіть скрипт використовуючи аліаси для назв полів.
=========================================================*/

SELECT r.region_name AS region,
COUNT(l.street_address) AS count_street_address,
COUNT(c.country_name) AS count_country_name
FROM hr.locations l
JOIN hr.countries c ON l.country_id = c.country_id
JOIN hr.regions r ON c.region_id = r.region_id
GROUP BY r.region_name
HAVING COUNT(c.country_name) > 6


