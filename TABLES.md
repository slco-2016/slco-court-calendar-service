# VINE Table Creation Statements

This document contains mysql table creation statements.

## `Case`


## `CourtEvent`


## `Charge`


## `CalendarDelete`

## `Judge`

```` sql
CREATE TABLE `judges` (
  `ju` varchar(255) DEFAULT NULL,
  `locn_code` varchar(255) DEFAULT NULL,
  `court_type` varchar(255) DEFAULT NULL,
  `party_num` int(11) DEFAULT NULL,
  `case_num` varchar(255) DEFAULT NULL,
  `appear_date` varchar(255) DEFAULT NULL,
  `time` varchar(255) DEFAULT NULL,
  `hearing_code` varchar(255) DEFAULT NULL,
  `create_datetime` varchar(255) DEFAULT NULL,
  `judge_id` int(11) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
````
