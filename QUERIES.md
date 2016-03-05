# VINE Queries

This document contains preliminary queries of VINE data that has been imported into a database.

## Distribution of Charge Levels

```` sql
SELECT severity, count(*)
FROM vine_charges
GROUP BY 1
ORDER BY 2 desc
````

=>

severity	| row_count
---	| ---
MB	| 2567
F3	| 1013
MA	| 789
MC	| 671
F2	| 379
IN	| 225
F1	| 101
NA	| 7

## Types of Charges

```` sql
SELECT
  severity
  ,viol_code
  ,offense_descr
  ,count(*) AS row_count
FROM vine_charges
GROUP BY 1,2,3
ORDER BY 1,2,3
````

## Cases per Day

```` sql
SELECT
STR_TO_DATE(appear_date, '%m/%d/%Y') AS appear_date
,count(DISTINCT concat(locn_code," - ", case_num)) AS case_count
FROM vine_court_events
GROUP BY 1
ORDER BY 1
````

=>

appear_date	| case_count
---	| ---
2016-03-04	| 92
2016-03-07	| 248
2016-03-08	| 155
2016-03-09	| 162
2016-03-10	| 115
2016-03-11	| 52
2016-03-14	| 133
2016-03-15	| 122
2016-03-16	| 96
2016-03-17	| 106
2016-03-18	| 34
2016-03-21	| 71
2016-03-22	| 73
2016-03-23	| 41
2016-03-24	| 73
2016-03-25	| 14
2016-03-28	| 29
2016-03-29	| 26
2016-03-30	| 38
2016-03-31	| 52
2016-04-01	| 7
2016-04-04	| 42
2016-04-05	| 46
2016-04-06	| 47
2016-04-07	| 74
2016-04-08	| 12
2016-04-11	| 50
2016-04-12	| 42
2016-04-13	| 54
2016-04-14	| 42
2016-04-15	| 3
2016-04-18	| 28
2016-04-19	| 22
2016-04-20	| 11
2016-04-21	| 9
2016-04-22	| 2
2016-04-25	| 14
2016-04-26	| 16
2016-04-27	| 10
2016-04-28	| 35
2016-04-29	| 3
2016-05-02	| 22
2016-05-03	| 38
2016-05-04	| 4
2016-05-05	| 26
2016-05-06	| 13
2016-05-09	| 11
2016-05-10	| 6
2016-05-11	| 10
2016-05-12	| 7
2016-05-13	| 3
2016-05-16	| 1
2016-05-17	| 6
2016-05-18	| 3
2016-05-19	| 5
2016-05-23	| 4
2016-05-24	| 1
2016-05-25	| 5
2016-05-26	| 7
2016-05-27	| 1
2016-06-01	| 6
2016-06-02	| 8
2016-06-06	| 2
2016-06-07	| 1
2016-06-09	| 2
2016-06-10	| 1
2016-06-13	| 1
2016-06-14	| 3
2016-06-15	| 3
2016-06-16	| 2
2016-06-20	| 1
2016-06-21	| 2
2016-06-22	| 1
2016-06-23	| 1
2016-06-24	| 1
2016-06-27	| 3
2016-06-28	| 1
2016-06-29	| 1
2016-06-30	| 2
2016-07-01	| 1
2016-07-05	| 6
2016-07-06	| 2
2016-07-07	| 3
2016-07-08	| 1
2016-07-11	| 2
2016-07-14	| 1
2016-07-17	| 1
2016-07-18	| 1
2016-07-21	| 1
2016-07-27	| 1
2016-07-28	| 1
2016-07-29	| 1
2016-08-04	| 1
2016-08-05	| 1
2016-08-09	| 1
2016-08-19	| 1
2016-08-23	| 1
2016-08-24	| 1
2016-08-25	| 1
2016-08-26	| 1
2016-08-31	| 1
2016-09-01	| 2
2016-09-08	| 5
2016-09-15	| 1
2016-09-27	| 1
2016-10-04	| 1
2016-10-20	| 1
2016-10-27	| 9
2016-12-01	| 3
2016-12-15	| 1
2016-12-16	| 1
2017-01-24	| 1
2017-01-26	| 1
2017-02-02	| 7
2017-02-07	| 1
2017-02-09	| 8
2017-02-13	| 1
2017-03-10	| 2
2017-09-08	| 2
2017-10-15	| 1
2017-11-13	| 1
2017-11-14	| 1
2017-12-13	| 2
2018-01-27	| 1
2018-05-14	| 1
2018-10-14	| 1
2019-08-03	| 6
2020-04-19	| 2
2026-03-27	| 1
2026-05-08	| 2
2027-11-01	| 1
2066-10-02	| 1
2080-11-24	| 1
2152-09-27	| 1
2203-01-16	| 1
2207-11-01	| 1
2209-12-07	| 1
2604-01-12	| 1
2704-05-01	| 1
2903-07-01	| 1
2907-08-01	| 1
2997-11-25	| 1
3003-06-01	| 1
3006-09-20	| 3
3008-08-18	| 1
3010-03-11	| 1
3015-11-30	| 1
3030-01-20	| 1
3095-01-01	| 1
3107-01-21	| 1
3828-04-02	| 1
4206-01-21	| 1
4208-01-01	| 1
5004-02-08	| 1
5006-08-16	| 1
5008-01-12	| 1
5963-03-01	| 1
6008-01-01	| 1
7008-06-01	| 1
8030-01-02	| 1
8275-03-01	| 1
9007-01-02	| 1
9007-01-10	| 1
9047-01-11	| 1


## API Response Preparation

```` sql
SELECT
  c.locn_code AS court_code
  ,c.court_type
  ,c.case_num AS case_number
  ,c.party_num AS party_number
  -- ,c.first_name AS defendant_first_name
  -- ,c.last_name AS defendant_last_name
  ,"FIRST MIDDLE" AS defendant_first_name -- temporary redaction to prevent names from hitting github
  ,"LAST" AS defendant_last_name -- temporary redaction to prevent names from hitting github
  ,STR_TO_DATE(c.birth_date, '%m/%d/%Y') AS defendant_birth_date
  ,STR_TO_DATE(e.appear_date, '%m/%d/%Y') AS appear_date
  ,e.time AS appear_time
  ,e.hearing_code
  ,e.room AS court_room
FROM vine_cases c
JOIN vine_court_events e ON e.locn_code = c.locn_code AND e.case_num = c.case_num
ORDER BY c.locn_code, c.case_num, c.party_num
````
