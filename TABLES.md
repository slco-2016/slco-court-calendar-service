# VINE Table Creation Statements

This document contains preliminary mysql table-creation statements.

## `VineCase`

```` sql
CREATE TABLE `vine_cases` (
  `ca` varchar(255) DEFAULT NULL,
  `locn_code` varchar(255) DEFAULT NULL,
  `court_type` varchar(255) DEFAULT NULL,
  `party_num` int(11) DEFAULT NULL,
  `case_num` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `disp_date` varchar(255) DEFAULT NULL,
  `disp_code` varchar(255) DEFAULT NULL,
  `bail_amt` varchar(255) DEFAULT NULL,
  `blank_field` varchar(255) DEFAULT NULL,
  `birth_date` varchar(255) DEFAULT NULL,
  `race_code` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `disposition_descry` varchar(255) DEFAULT NULL,
  `booking_num` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
````

## `VineCourtEvent`

```` sql
CREATE TABLE `vine_court_events` (
  `ce` varchar(255) DEFAULT NULL,
  `locn_code` varchar(255) DEFAULT NULL,
  `court_type` varchar(255) DEFAULT NULL,
  `party_num` int(11) DEFAULT NULL,
  `case_num` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `appear_date` varchar(255) DEFAULT NULL,
  `time` varchar(255) DEFAULT NULL,
  `hearing_code` varchar(255) DEFAULT NULL,
  `room` varchar(255) DEFAULT NULL,
  `int_case_num` int(11) DEFAULT NULL,
  `create_datetime` varchar(255) DEFAULT NULL,
  `cancel_datetime` varchar(255) DEFAULT NULL,
  `cancel_reason` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
````

## `VineCharge`


## `VineCalendarDelete`

## `CjsJudge`

```` sql
CREATE TABLE `cjs_judges` (
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
