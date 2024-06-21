%run ../Includes/Classroom-Setup

-- Create a new table called fireIncidents for this dataset. Be sure to use options to properly parse the data.

DROP TABLE IF EXISTS fireIncidents;

CREATE TABLE IF NOT EXISTS fireIncidents
USING csv
OPTIONS (
  header "true",
  path "/mnt/davis/fire-incidents/fire-incidents-2016.csv",
  inferSchema "true"
)

-- Question 1
-- Return the first 10 lines of the data. On the Coursera platform, input the result to the following question:
-- What is the first value for "Incident Number"?

select * from fireIncidents

-- Q2 Return all incidents that occurred on Conor's birthday in 2016. For those of you who forgot his birthday, it's April 4th. On the Coursera platform, input the result to the following question:
-- What is the first value for "Incident Number" on April 4th, 2016?
-- Remember to use backticks (``) instead of single quotes ('') for columns that have spaces in the name. **

SELECT `Incident Number`,`Incident Date` from fireIncidents
WHERE `Incident Date` = '2016-04-04'

-- Q3 Return all incidents that occurred on Conor's or Brooke's birthday. For those of you who forgot her birthday too, it's 9/27.
-- Is the first fire call in this table on Brooke or Conor's birthday?

select (*) from fireIncidents
where `Incident Date` = "04/04/2016" or `Incident Date` = "27/09/2016"
-- OR
SELECT `Incident Number`,`Incident Date`,`Station Area` FROM fireIncidents
where `Incident Date` Like '%-04-04' -- IF Month 4 had incidents, then logically there will be the first call

-- Q4 Return all incidents on either Conor or Brooke's birthday where the Station Area is greater than 20.
-- What is the "Station Area" for the first fire call in this table?

select count(`Incident Number`) as incidents from fireIncidents
where `Incident Date` = "04/04/2016" 

-- Q5 How many incidents were on Conor's birthday in 2016?

select count( distinct `Incident Number`) from fireincidents
where `Incident Date` like '2016-04-04'

-- Q6 How many fire calls had an "Ignition Cause" of "4 act of nature"?

SELECT count(*) as fulli FROM fireincidents
WHERE `Ignition Cause` = '4 act of nature'

-- Q7 What is the most common "Ignition Cause"? (Put the entire string)

SELECT `Ignition Cause`,count(`Ignition Cause`) FROM fireincidents
GROUP BY `Ignition Cause`

-- Return the total counts by Ignition Cause sorted in descending order.

SELECT `Ignition Cause`,count(`Ignition Cause`) FROM fireincidents
GROUP BY `Ignition Cause`
ORDER BY count(`Ignition Cause`) DESC

CREATE TABLE IF NOT EXISTS FireCalls
USING csv
OPTIONS (
  header "true",
  path "/mnt/davis/fire-calls/fire-calls-truncated-comma.csv",
  inferSchema "true"
)

SELECT * FROM fireincidents
INNER JOIN FireCalls ON fireincidents.Battalion = FireCalls.Battalion

-- Q8 Count the total incidents from the two tables joined on Battalion.
-- What is the total incidents from the two joined tables?

SELECT COUNT(*) AS total_incidents
FROM fireincidents 
INNER JOIN firecalls 
ON fireincidents.Battalion = firecalls.Battalion;

