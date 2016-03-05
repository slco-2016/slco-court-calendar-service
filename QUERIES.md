# VINE Queries

This document contains preliminary queries of VINE data that has been imported into a database.

# Distribution of Charge Levels

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
