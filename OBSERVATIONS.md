# VINE Data Observations

This document describes data posted as part of the Victim Information and Notification Everyday (VINE) system.

## Importation Considerations

This document describes considerations for importing VINE data files into a database.

 + Fields are separated by `\t`.
 + Fields are enclosed by `"`.
 + Fields are escaped by `\ or "`.
 + Lines are terminated by `\n`.
 + each file contains a first column which is non-functional except it identifies the type of file.
 + each file contains a last column which is empty.



## Entities

Many entities include the `locn_code` attribute which identifies the court, but where is the lookup table that provides court names for each `locn_code`?

Some attributes describe similar concepts but use different prefixes (e.g. `jdmt` vs `judgement`) and suffixes (e.g. `descr` vs `descry`).

### `VineCase`

There are no unique row identifiers. :-/

There are multiple rows per `case_num`, and there are no commonalities between rows which contain the same `case_num`.

There are no multiple rows per `case_num` per `party_num`. This suggests a composite primary key on (`case_num`,`party_num`).

There are no multiple rows per `party_num`, which suggests `party_num` might be a unique identifier, however the more likely cause of this lack of duplication is the fact that a defendant/party happens not to have multiple cases in today's file.

### `VineCourtEvent`

There are no unique row identifiers. :-/

There are multiple rows per `case_num`, containing the same defendant information, indicating multiple court hearings on different dates and times.

There are many overlapping attributes between this entity and the `CjsJudge` entity.

### `VineCharge`

There are no unique row identifiers. :-/

There are multiple rows per `case_num`, each row depicting a different charge. Some cases, as indicated by their `case_num` have multiple instances of the same charge, as indicated by its `viol_code`, `severity`, `offense_descr`, and `viol_datetime`. The way to differentiate between multiple occurrences of the same type of charge for the same type of case comes from unique values of the `seq` attribute.

Some `offense_descr` attribute values include "FAILURE TO APPEAR". We've been hoping to find data on FTAs, but how comprehensive is this coverage?


### `VineCalendarDelete`



### `CjsJudge`

There are no unique row identifiers. :-/

There are multiple rows per judge.

There are multiple rows per judge, per case number, but the only difference between the duplicate records seems to be the `create_datetime`. There might be the opportunity to overwrite previous rows which match in all attributes except for `create_datetime`.

There are many overlapping attributes between this entity and the `VineCourtEvent` entity.
