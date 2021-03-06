# VINE Data Observations

This document describes data posted as part of the Victim Information and Notification Everyday (VINE) system.

## Importation Considerations

This document describes considerations for importing VINE data files into a database.

 + Fields are separated by `\t`.
 + Fields are enclosed by `"`.
 + Fields are escaped by `\ or "`.
 + Lines are terminated by `\n`. EDIT: only because I imported them by skipping the last column, else lines are terminated by `\r\r\n`.
 + each file contains a first column which is non-functional except it identifies the type of file.
 + each file contains a last column which is empty.



## Entities

Many entities include the `locn_code` attribute which identifies the court, but where is the lookup table that provides court names for each `locn_code`?

Some attributes describe similar concepts but use different prefixes (e.g. `jdmt` vs `judgement`) and suffixes (e.g. `descr` vs `descry`).

### `VineCase`

There are 2,291 rows.
 + all rows have `last_name`, `locn_code`, `party_num`, `case_num`
 + 84 have a `bail_amt`
 + 401 have a `booking_num`
 + 1,039 have a `race_code`
 + 972 have a `disp_code`
 + 79 have a `disp_date`
 + all but 5 have a `birth_date`
 + all but 2 have a `first_name`; these defendants are corporations having the corporation name listed in the `last_name` attribute

There are no unique row identifiers. :-/

There are multiple rows per `case_num`, and there are no commonalities between rows which contain the same `case_num`.

There are no multiple rows per `case_num` per `party_num`. This suggests a possible composite primary key on (`case_num`,`party_num`).

There are no multiple rows per `party_num`, which suggests `party_num` might be a unique identifier, however the more likely cause of this lack of duplication is the fact that a defendant/party happens not to have multiple cases in today's file.

EDIT: There are no duplications for combinations of `locn_code` and `case_num`; this fact, coupled with our existing knowledge of how case numbers work, provides strong indication that there is a composite primary key on (`locn_code` and `case_num`).

### `VineCourtEvent`

There are 2,804 rows.

There are no unique row identifiers. :-/

There are multiple rows per `case_num`, containing the same defendant information, indicating multiple court hearings on different dates and times.

Some rows have `appear_date` values outside the expected range (e.g. "9007-01-02" and "3030-01-20"). :-/

There are many overlapping attributes between this entity and the `CjsJudge` entity.


### `VineCharge`

There are 5,752 rows.

There are no unique row identifiers. :-/

There are multiple rows per `case_num`, each row depicting a different charge. Some cases, as indicated by their `case_num` have multiple instances of the same charge, as indicated by its `viol_code`, `severity`, `offense_descr`, and `viol_datetime`. The way to differentiate between multiple occurrences of the same type of charge for the same type of case comes from unique values of the `seq` attribute.

Some `offense_descr` attribute values include "FAILURE TO APPEAR". We've been hoping to find data on FTAs, but how comprehensive is this coverage?


### `VineDelete`

There are 54 rows.

There are no unique row identifiers. :-/

There are multiple rows per `case_num`, each indicating a different `appear_date` which has been cancelled. There likely could be multiple calendar event deletions for the same combination of `case_num` and `appear_date`.

### `CjsJudge`

There are 2,772 rows.

There are no unique row identifiers. :-/

There are multiple rows per judge.

There are multiple rows per judge, per case number, but the only difference between the duplicate records seems to be the `create_datetime`. There might be the opportunity to overwrite previous rows which match in all attributes except for `create_datetime`.

There are many overlapping attributes between this entity and the `VineCourtEvent` entity.
