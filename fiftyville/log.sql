-- Keep a log of any SQL queries you execute as you solve the mystery.

--Find data for specific crime
SELECT
    *
FROM
    CRIME_SCENE_REPORTS
WHERE
    YEAR = 2023
    AND MONTH = 7
    AND DAY = 28
    AND STREET = 'Humphrey Street';

/*
+-----+------+-------+-----+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| id  | year | month | day |     street      |                                                                                                       description                                                                                                        |
+-----+------+-------+-----+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| 295 | 2023 | 7     | 28  | Humphrey Street | Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery. Interviews were conducted today with three witnesses who were present at the time – each of their interview transcripts mentions the bakery. |
| 297 | 2023 | 7     | 28  | Humphrey Street | Littering took place at 16:36. No known witnesses.                                                                                                                                                                       |
+-----+------+-------+-----+-----------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
 */

-- Get information from bakery at specific date and time
SELECT
    *
FROM
    BAKERY_SECURITY_LOGS
WHERE
    YEAR = 2023
    AND MONTH = 7
    AND DAY = 28
    AND HOUR = 10
    AND MINUTE BETWEEN 5 AND 25;

/*
+-----+------+-------+-----+------+--------+----------+---------------+
| id  | year | month | day | hour | minute | activity | license_plate |
+-----+------+-------+-----+------+--------+----------+---------------+
| 258 | 2023 | 7     | 28  | 10   | 8      | entrance | R3G7486       |
| 259 | 2023 | 7     | 28  | 10   | 14     | entrance | 13FNH73       |
| 260 | 2023 | 7     | 28  | 10   | 16     | exit     | 5P2BI95       |
| 261 | 2023 | 7     | 28  | 10   | 18     | exit     | 94KL13X       |
| 262 | 2023 | 7     | 28  | 10   | 18     | exit     | 6P58WS2       |
| 263 | 2023 | 7     | 28  | 10   | 19     | exit     | 4328GD8       |
| 264 | 2023 | 7     | 28  | 10   | 20     | exit     | G412CB7       |
| 265 | 2023 | 7     | 28  | 10   | 21     | exit     | L93JTIZ       |
| 266 | 2023 | 7     | 28  | 10   | 23     | exit     | 322W7JE       |
| 267 | 2023 | 7     | 28  | 10   | 23     | exit     | 0NTHK55       |
 */

-- Get data from interview transcripts from the three witnesses
SELECT
    *
FROM
    INTERVIEWS
WHERE
    YEAR = 2023
    AND MONTH = 7
    AND DAY = 28;

/*
+-----+---------+------+-------+-----+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| id  |  name   | year | month | day |                                                                                                                                                     transcript                                                                                                                                                      |
+-----+---------+------+-------+-----+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+                                                                                                                 |
| 161 | Ruth    | 2023 | 7     | 28  | Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.                                                          |
| 162 | Eugene  | 2023 | 7     | 28  | I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.                                                                                                 |
| 163 | Raymond | 2023 | 7     | 28  | As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket. |                                                                  |
+-----+---------+------+-------+-----+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
 */

--Get data from atm transactions
SELECT
    *
FROM
    ATM_TRANSACTIONS
WHERE
    YEAR = 2023
    AND MONTH = 7
    AND DAY = 28
    AND ATM_LOCATION = 'Leggett Street'
    AND TRANSACTION_TYPE = 'withdraw';

/*
+-----+----------------+------+-------+-----+----------------+------------------+--------+
| id  | account_number | year | month | day |  atm_location  | transaction_type | amount |
+-----+----------------+------+-------+-----+----------------+------------------+--------+
| 246 | 28500762       | 2023 | 7     | 28  | Leggett Street | withdraw         | 48     |
| 264 | 28296815       | 2023 | 7     | 28  | Leggett Street | withdraw         | 20     |
| 266 | 76054385       | 2023 | 7     | 28  | Leggett Street | withdraw         | 60     |
| 267 | 49610011       | 2023 | 7     | 28  | Leggett Street | withdraw         | 50     |
| 269 | 16153065       | 2023 | 7     | 28  | Leggett Street | withdraw         | 80     |
| 288 | 25506511       | 2023 | 7     | 28  | Leggett Street | withdraw         | 20     |
| 313 | 81061156       | 2023 | 7     | 28  | Leggett Street | withdraw         | 30     |
| 336 | 26013199       | 2023 | 7     | 28  | Leggett Street | withdraw         | 35     |
+-----+----------------+------+-------+-----+----------------+------------------+--------+
 */

-- Get bank account and people data
SELECT
    *
FROM
    BANK_ACCOUNTS B,
    PEOPLE P
WHERE
    P.ID = B.PERSON_ID
    AND ACCOUNT_NUMBER IN (
        SELECT
            ACCOUNT_NUMBER
        FROM
            ATM_TRANSACTIONS
        WHERE
            YEAR = 2023
            AND MONTH = 7
            AND DAY = 28
            AND ATM_LOCATION = 'Leggett Street'
            AND TRANSACTION_TYPE = 'withdraw'
    );

/*
+----------------+-----------+---------------+--------+---------+----------------+-----------------+---------------+
| account_number | person_id | creation_year |   id   |  name   |  phone_number  | passport_number | license_plate |
+----------------+-----------+---------------+--------+---------+----------------+-----------------+---------------+
| 49610011       | 686048    | 2010          | 686048 | Bruce   | (367) 555-5533 | 5773159633      | 94KL13X       |
| 26013199       | 514354    | 2012          | 514354 | Diana   | (770) 555-1861 | 3592750733      | 322W7JE       |
| 16153065       | 458378    | 2012          | 458378 | Brooke  | (122) 555-4581 | 4408372428      | QX4YZN3       |
| 28296815       | 395717    | 2014          | 395717 | Kenny   | (826) 555-1652 | 9878712108      | 30G67EN       |
| 25506511       | 396669    | 2014          | 396669 | Iman    | (829) 555-5269 | 7049073643      | L93JTIZ       |
| 28500762       | 467400    | 2014          | 467400 | Luca    | (389) 555-5198 | 8496433585      | 4328GD8       |
| 76054385       | 449774    | 2015          | 449774 | Taylor  | (286) 555-6063 | 1988161715      | 1106N58       |
| 81061156       | 438727    | 2018          | 438727 | Benista | (338) 555-6650 | 9586786673      | 8X428L0       |
+----------------+-----------+---------------+--------+---------+----------------+-----------------+---------------+
 */

-- Add lincense plate check
SELECT
    *
FROM
    BANK_ACCOUNTS B,
    PEOPLE P
WHERE
    P.ID = B.PERSON_ID
    AND ACCOUNT_NUMBER IN (
        SELECT
            ACCOUNT_NUMBER
        FROM
            ATM_TRANSACTIONS
        WHERE
            YEAR = 2023
            AND MONTH = 7
            AND DAY = 28
            AND ATM_LOCATION = 'Leggett Street'
            AND TRANSACTION_TYPE = 'withdraw'
    )
    AND LICENSE_PLATE IN (
        SELECT
            LICENSE_PLATE
        FROM
            BAKERY_SECURITY_LOGS
        WHERE
            YEAR = 2023
            AND MONTH = 7
            AND DAY = 28
            AND HOUR = 10
            AND MINUTE BETWEEN 5 AND 25
    );

/*
+----------------+-----------+---------------+--------+-------+----------------+-----------------+---------------+
| account_number | person_id | creation_year |   id   | name  |  phone_number  | passport_number | license_plate |
+----------------+-----------+---------------+--------+-------+----------------+-----------------+---------------+
| 49610011       | 686048    | 2010          | 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       |
| 26013199       | 514354    | 2012          | 514354 | Diana | (770) 555-1861 | 3592750733      | 322W7JE       |
| 25506511       | 396669    | 2014          | 396669 | Iman  | (829) 555-5269 | 7049073643      | L93JTIZ       |
| 28500762       | 467400    | 2014          | 467400 | Luca  | (389) 555-5198 | 8496433585      | 4328GD8       |
+----------------+-----------+---------------+--------+-------+----------------+-----------------+---------------+
 */

-- Get phone call info
SELECT
    *
FROM
    PHONE_CALLS
WHERE
    YEAR = 2023
    AND MONTH = 7
    AND DAY = 28
    AND DURATION <= 60;

/*
+-----+----------------+----------------+------+-------+-----+----------+
| id  |     caller     |    receiver    | year | month | day | duration |
+-----+----------------+----------------+------+-------+-----+----------+
| 221 | (130) 555-0289 | (996) 555-8899 | 2023 | 7     | 28  | 51       |
| 224 | (499) 555-9472 | (892) 555-8872 | 2023 | 7     | 28  | 36       |
| 233 | (367) 555-5533 | (375) 555-8161 | 2023 | 7     | 28  | 45       |
| 234 | (609) 555-5876 | (389) 555-5198 | 2023 | 7     | 28  | 60       |
| 251 | (499) 555-9472 | (717) 555-1342 | 2023 | 7     | 28  | 50       |
| 254 | (286) 555-6063 | (676) 555-6554 | 2023 | 7     | 28  | 43       |
| 255 | (770) 555-1861 | (725) 555-3243 | 2023 | 7     | 28  | 49       |
| 261 | (031) 555-6622 | (910) 555-3251 | 2023 | 7     | 28  | 38       |
| 279 | (826) 555-1652 | (066) 555-9701 | 2023 | 7     | 28  | 55       |
| 281 | (338) 555-6650 | (704) 555-2131 | 2023 | 7     | 28  | 54       |
 */

-- Cross phone call info with previus data
SELECT
    *
FROM
    BANK_ACCOUNTS B,
    PEOPLE P
WHERE
    P.ID = B.PERSON_ID
    AND ACCOUNT_NUMBER IN (
        SELECT
            ACCOUNT_NUMBER
        FROM
            ATM_TRANSACTIONS
        WHERE
            YEAR = 2023
            AND MONTH = 7
            AND DAY = 28
            AND ATM_LOCATION = 'Leggett Street'
            AND TRANSACTION_TYPE = 'withdraw'
    )
    AND LICENSE_PLATE IN (
        SELECT
            LICENSE_PLATE
        FROM
            BAKERY_SECURITY_LOGS
        WHERE
            YEAR = 2023
            AND MONTH = 7
            AND DAY = 28
            AND HOUR = 10
            AND MINUTE BETWEEN 5 AND 25
    )
    AND PHONE_NUMBER IN (
        SELECT
            CALLER
        FROM
            PHONE_CALLS
        WHERE
            YEAR = 2023
            AND MONTH = 7
            AND DAY = 28
            AND DURATION <= 60
    );

/*
+----------------+-----------+---------------+--------+-------+----------------+-----------------+---------------+
| account_number | person_id | creation_year |   id   | name  |  phone_number  | passport_number | license_plate |
+----------------+-----------+---------------+--------+-------+----------------+-----------------+---------------+
| 49610011       | 686048    | 2010          | 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       |
| 26013199       | 514354    | 2012          | 514354 | Diana | (770) 555-1861 | 3592750733      | 322W7JE       |
+----------------+-----------+---------------+--------+-------+----------------+-----------------+---------------+
 */

--Get fight info
SELECT
    F.ID,
    FA.CITY ORIGIN,
    TA.CITY DESTINATION,
    F.YEAR,
    F.MONTH,
    F.DAY,
    F.HOUR,
    F.MINUTE
FROM
    FLIGHTS F,
    AIRPORTS FA,
    AIRPORTS TA
WHERE
    F.YEAR = 2023
    AND F.MONTH = 7
    AND F.DAY = 29
    AND FA.ID = F.ORIGIN_AIRPORT_ID
    AND TA.ID = F.DESTINATION_AIRPORT_ID
    AND TA.CITY != 'Fiftyville'
ORDER BY
    F.HOUR ASC,
    F.MINUTE ASC
LIMIT
    1;

/*
+----+------------+---------------+------+-------+-----+------+--------+
| id |   origin   |  destination  | year | month | day | hour | minute |
+----+------------+---------------+------+-------+-----+------+--------+
| 36 | Fiftyville | New York City | 2023 | 7     | 29  | 8    | 20     |
| 43 | Fiftyville | Chicago       | 2023 | 7     | 29  | 9    | 30     |
| 23 | Fiftyville | San Francisco | 2023 | 7     | 29  | 12   | 15     |
| 53 | Fiftyville | Tokyo         | 2023 | 7     | 29  | 15   | 20     |
| 18 | Fiftyville | Boston        | 2023 | 7     | 29  | 16   | 0      |
+----+------------+---------------+------+-------+-----+------+--------+
 */

-- Get passenger info
SELECT
    *
FROM
    PASSENGERS
WHERE
    FLIGHT_ID IN (
        SELECT
            F.ID
        FROM
            FLIGHTS F,
            AIRPORTS FA,
            AIRPORTS TA
        WHERE
            F.YEAR = 2023
            AND F.MONTH = 7
            AND F.DAY = 29
            AND FA.ID = F.ORIGIN_AIRPORT_ID
            AND TA.ID = F.DESTINATION_AIRPORT_ID
            AND TA.CITY != 'Fiftyville'
        ORDER BY
            F.HOUR ASC,
            F.MINUTE ASC
        LIMIT
            1
    );

/*
+-----------+-----------------+------+
| flight_id | passport_number | seat |
+-----------+-----------------+------+
| 36        | 7214083635      | 2A   |
| 36        | 1695452385      | 3B   |
| 36        | 5773159633      | 4A   |
| 36        | 1540955065      | 5C   |
| 36        | 8294398571      | 6C   |
| 36        | 1988161715      | 6D   |
| 36        | 9878712108      | 7A   |
| 36        | 8496433585      | 7B   |
+-----------+-----------------+------+
 */

-- Cross passenger info with previus data
SELECT
    *
FROM
    BANK_ACCOUNTS B,
    PEOPLE P
WHERE
    P.ID = B.PERSON_ID
    AND ACCOUNT_NUMBER IN (
        SELECT
            ACCOUNT_NUMBER
        FROM
            ATM_TRANSACTIONS
        WHERE
            YEAR = 2023
            AND MONTH = 7
            AND DAY = 28
            AND ATM_LOCATION = 'Leggett Street'
            AND TRANSACTION_TYPE = 'withdraw'
    )
    AND LICENSE_PLATE IN (
        SELECT
            LICENSE_PLATE
        FROM
            BAKERY_SECURITY_LOGS
        WHERE
            YEAR = 2023
            AND MONTH = 7
            AND DAY = 28
            AND HOUR = 10
            AND MINUTE BETWEEN 5 AND 25
    )
    AND PHONE_NUMBER IN (
        SELECT
            CALLER
        FROM
            PHONE_CALLS
        WHERE
            YEAR = 2023
            AND MONTH = 7
            AND DAY = 28
            AND DURATION <= 60
    )
    AND passport_number IN (
        SELECT
            PASSPORT_NUMBER
        FROM
            PASSENGERS
        WHERE
            FLIGHT_ID IN (
                SELECT
                    F.ID
                FROM
                    FLIGHTS F,
                    AIRPORTS FA,
                    AIRPORTS TA
                WHERE
                    F.YEAR = 2023
                    AND F.MONTH = 7
                    AND F.DAY = 29
                    AND FA.ID = F.ORIGIN_AIRPORT_ID
                    AND TA.ID = F.DESTINATION_AIRPORT_ID
                    AND TA.CITY != 'Fiftyville'
                ORDER BY
                    F.HOUR ASC,
                    F.MINUTE ASC
                LIMIT
                    1
            )
    );

/*
+----------------+-----------+---------------+--------+-------+----------------+-----------------+---------------+
| account_number | person_id | creation_year |   id   | name  |  phone_number  | passport_number | license_plate |
+----------------+-----------+---------------+--------+-------+----------------+-----------------+---------------+
| 49610011       | 686048    | 2010          | 686048 | Bruce | (367) 555-5533 | 5773159633      | 94KL13X       |
+----------------+-----------+---------------+--------+-------+----------------+-----------------+---------------+
 */

--Get The accomplice

WITH THIEF AS
(
    SELECT
        *
    FROM
        BANK_ACCOUNTS B,
        PEOPLE P
    WHERE
        P.ID = B.PERSON_ID
        AND ACCOUNT_NUMBER IN (
            SELECT
                ACCOUNT_NUMBER
            FROM
                ATM_TRANSACTIONS
            WHERE
                YEAR = 2023
                AND MONTH = 7
                AND DAY = 28
                AND ATM_LOCATION = 'Leggett Street'
                AND TRANSACTION_TYPE = 'withdraw'
        )
        AND LICENSE_PLATE IN (
            SELECT
                LICENSE_PLATE
            FROM
                BAKERY_SECURITY_LOGS
            WHERE
                YEAR = 2023
                AND MONTH = 7
                AND DAY = 28
                AND HOUR = 10
                AND MINUTE BETWEEN 5 AND 25
        )
        AND PHONE_NUMBER IN (
            SELECT
                CALLER
            FROM
                PHONE_CALLS
            WHERE
                YEAR = 2023
                AND MONTH = 7
                AND DAY = 28
                AND DURATION <= 60
        )
        AND PASSPORT_NUMBER IN (
            SELECT
                PASSPORT_NUMBER
            FROM
                PASSENGERS
            WHERE
                FLIGHT_ID IN (
                    SELECT
                        F.ID
                    FROM
                        FLIGHTS F,
                        AIRPORTS FA,
                        AIRPORTS TA
                    WHERE
                        F.YEAR = 2023
                        AND F.MONTH = 7
                        AND F.DAY = 29
                        AND FA.ID = F.ORIGIN_AIRPORT_ID
                        AND TA.ID = F.DESTINATION_AIRPORT_ID
                        AND TA.CITY != 'Fiftyville'
                    ORDER BY
                        F.HOUR ASC,
                        F.MINUTE ASC
                    LIMIT
                        1
                )
        )
)
SELECT
    A.*
FROM
    PHONE_CALLS P,
    THIEF T,
    PEOPLE A
WHERE
    P.YEAR = 2023
    AND P.MONTH = 7
    AND P.DAY = 28
    AND P.DURATION <= 60
    AND P.CALLER = T.PHONE_NUMBER
    AND A.PHONE_NUMBER = P.RECEIVER;


/*
+--------+-------+----------------+-----------------+---------------+
|   id   | name  |  phone_number  | passport_number | license_plate |
+--------+-------+----------------+-----------------+---------------+
| 864400 | Robin | (375) 555-8161 | NULL            | 4V16VO0       |
+--------+-------+----------------+-----------------+---------------+
 */
