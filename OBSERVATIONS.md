# VINE Data Observations

This document describes data posted as part of the Victim Information and Notification Everyday (VINE) system.

## `Case`


## `CourtEvent`




## `Charge`




## `CalendarDelete`



## `Judge`

There are no unique row identifiers. :-/

There are multiple rows per judge.

There are multiple rows per judge, per case number, but the only difference between the duplicate records seems to be the `create_datetime`. There might be the opportunity to overwrite previous rows which match in all attributes except for `create_datetime`.
