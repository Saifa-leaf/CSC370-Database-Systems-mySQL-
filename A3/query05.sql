-- Retrieve in descending order of labour force size
-- all counties that had unemployment rates over 10%
-- in the 2008 census.
-- Hint: Unemployment rate = unemployment / labour force
-- 1.1 marks: <9 operators
-- 1.0 marks: <10 operators
-- 1.0 marks: <15 operators
-- 0.8 marks: correct answer

-- Replace this comment line with the actual query
SELECT name, abbr, labour_force, (unemployed / labour_force)*100 AS 'Unemployment Rate' 
FROM CountyLabourStats 
JOIN County ON (CountyLabourStats.county = County.fips) 
JOIN State ON (State.id = County.state) 
WHERE (unemployed / labour_force) > 0.1 AND year = 2008 
ORDER BY labour_force DESC;