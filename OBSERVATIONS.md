# VINE Data Observations

This document describes data posted as part of the Victim Information and Notification Everyday (VINE) system.

## `VineCase`

There are no unique row identifiers. :-/

There are multiple rows per `case_num`, and there are no commonalities between rows which contain the same `case_num`.

There are no multiple rows per `case_num` per `party_num`. This suggests a composite primary key on (`case_num`,`party_num`).

There are no multiple rows per `party_num`, which suggests `party_num` might be a unique identifier, however the more likely cause of this lack of duplication is the fact that a defendant/party happens not to have multiple cases in today's file.

## `VineCourtEvent`

There are no unique row identifiers. :-/

There are multiple rows per `case_num`, containing the same defendant information, indicating multiple court hearings on different dates and times.

There are many overlapping attributes between this entity and the `CjsJudge` entity.

## `VineCharge`




## `VineCalendarDelete`



## `CjsJudge`

There are no unique row identifiers. :-/

There are multiple rows per judge.

There are multiple rows per judge, per case number, but the only difference between the duplicate records seems to be the `create_datetime`. There might be the opportunity to overwrite previous rows which match in all attributes except for `create_datetime`.

There are many overlapping attributes between this entity and the `VineCourtEvent` entity.
